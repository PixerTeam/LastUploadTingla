import 'package:flutter/foundation.dart';
import 'package:audio_service/audio_service.dart';
import 'package:tingla/variables/variables.dart';

import 'notifiers/play_button_notifier.dart';
import 'notifiers/progress_notifier.dart';
import 'services/service_locator.dart';

import 'package:tingla/database/book_schema_to_database.dart' as localBook;
import 'package:tingla/schema/book_schema.dart' as bookSchema;
import 'package:tingla/schema/head_schema.dart' as headSchema;

class PageManager {
  // Listeners: Updates going to the UI
  String? currentBookId;
  dynamic currentBook;

  final audioActiveNotifier = ValueNotifier<bool>(false);
  final currentSongNotifier = ValueNotifier<MediaItem?>(null);
  final currentSpeedNotifier = ValueNotifier<double>(1.0);

  final playlistNotifier = ValueNotifier<List<MediaItem>>([]);
  final progressNotifier = ProgressNotifier();

  final playButtonNotifier = PlayButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  final _audioHandler = getIt<AudioHandler>();

  // Events: Calls coming from the UI
  void init() async {
    _listenToChangesInPlaylist();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    _listenToChangesInSong();
  }

  Future<void> loadNetworkPlaylist(
      bookSchema.Book book, List<headSchema.HeadSchema> heads) async {
    List<MediaItem> mediaItems = [];
    int index = 0;
    currentSongNotifier.value = null;

    if (heads.isNotEmpty) {
      mediaItems = heads.map(
        (song) {
          String audioUrl =
              'https://tingla.pixer.uz/audio/${song.audios!.first.audioFile!.fileId}.${song.audios!.first.audioFile!.type}?ssid=${Variables.userToken}';

          index = (index % heads.length) + 1;

          return MediaItem(
            id: index.toString(),
            artUri: Uri.parse(book.data!.bookPhoto ?? ''),
            title: song.title ?? '',
            artist: book.data!.author!.authorName,
            duration: 
              Duration(seconds: song.audios!.first.audioFile!.duration),
            extras: {'url': audioUrl},
          );
        },
      ).toList();
    } else {
      List<int> audios = [1, 2];

      mediaItems = audios.map(
        (index) {
          return MediaItem(
            id: index.toString(),
            artUri: Uri.parse('https://source.unsplash.com/random/$index'),
            title: '$index',
            extras: {
              'url':
                  'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-$index.mp3'
            },
          );
        },
      ).toList();
    }

    currentBookId = 'n' + book.data!.id!;
    currentBook = book;
    currentSongNotifier.value = mediaItems.first;
    await _audioHandler.addQueueItems(mediaItems);
    audioActiveNotifier.value = true;
  }

  Future<void> loadLocalPlaylist(
    localBook.Book book,
    List<localBook.Audio> audios,
    List heads,
  ) async {
    currentSongNotifier.value = null;
    if (audios.isNotEmpty) {
      int index = 0;

      final mediaItems = audios.map(
        (song) {
          index = (index % audios.length) + 1;

          return MediaItem(
            id: index.toString(),
            artUri: Uri.parse(book.bookPhoto ?? ''),
            artist: book.authorName,
            duration: Duration(seconds: audios[index - 1].audioFile!.duration!),
            title: heads[index - 1].title ?? '',
            extras: {'url': 'file://' + song.audio.toString()},
          );
        },
      ).toList();

      currentSongNotifier.value = mediaItems.first;
      await _audioHandler.addQueueItems(mediaItems);
      audioActiveNotifier.value = true;
    }

    currentBook = book;
    currentBookId = 'l' + book.id!;
  }

  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) {
        playlistNotifier.value = [];
        currentSongNotifier.value = null;
      } else {
        currentSongNotifier.value = null;

        currentSongNotifier.value = playlist.first;
        playlistNotifier.value = playlist;
      }

      _updateSkipButtons();
    });
  }

  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenToBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );
    });
  }

  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongNotifier.value = mediaItem;

      _updateSkipButtons();
    });
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    currentSongNotifier.value = mediaItem;
    final playlist = _audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  void skipToQueueItem(int index) => _audioHandler.skipToQueueItem(index);

  void play() => _audioHandler.play();
  void pause() => _audioHandler.pause();
  void seek(Duration position) => _audioHandler.seek(position);
  void previous() => _audioHandler.skipToPrevious();
  void next() => _audioHandler.skipToNext();

  void skipToBack() {
    if (progressNotifier.value.current.inSeconds - 15 <= 0) {
      seek(Duration.zero);
    } else {
      seek(Duration(seconds: progressNotifier.value.current.inSeconds - 15));
    }
  }

  void skipToNext() {
    if (progressNotifier.value.current.inSeconds + 15 >=
        progressNotifier.value.total.inSeconds) {
      seek(progressNotifier.value.total);
    } else {
      seek(Duration(seconds: progressNotifier.value.current.inSeconds + 15));
    }
  }

  void shuffle() {
    final enable = !isShuffleModeEnabledNotifier.value;
    isShuffleModeEnabledNotifier.value = enable;
    if (enable) {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    } else {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    }
  }

  void remove() {
    final lastIndex = _audioHandler.queue.value.length - 1;
    if (lastIndex < 0) return;
    _audioHandler.removeQueueItemAt(lastIndex);
  }

  void dispose() {
    _audioHandler.customAction('dispose');
  }

  void stop() {
    currentBookId = null;
    currentBook = null;
    currentSongNotifier.value = null;
    playlistNotifier.value = [];
    audioActiveNotifier.value = false;
    _audioHandler.stop();
  }

  void setSpeed(double speed) {
    _audioHandler.setSpeed(speed);

    currentSpeedNotifier.value = speed;
  }
}
