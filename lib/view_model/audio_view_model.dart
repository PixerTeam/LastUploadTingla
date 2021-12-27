import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:tingla/schema/book_schema.dart' as bookSchema;
import 'package:tingla/schema/head_schema.dart' as headSchema;
import 'package:tingla/variables/variables.dart';

enum ButtonState {
  paused,
  playing,
  loading,
}

class ProgressBarState {
  const ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
}

class AudioViewModel extends ChangeNotifier {
  AudioViewModel() {
    init();
  }

  MediaItem? currentSong;
  bookSchema.Book? currentBook;

  ProgressBarState progressBarState = const ProgressBarState(
    buffered: Duration.zero,
    current: Duration.zero,
    total: Duration.zero,
  );

  ButtonState buttonState = ButtonState.paused;

  init() async {
    try {
      Variables.audioPlayer.addQueueItems([]);
      _listenToPlaybackState();
      _listenToCurrentPosition();
      _listenToBufferedPosition();
      _listenToTotalDuration();
      _listenToChangesInSong();
      print('Audio Player initilized ...');
    } catch (e) {
      print('Audio Player allready initilized ...');
    }
  }

  Future<void> loadPlaylist(
      bookSchema.Book book, List<headSchema.HeadSchema> heads) async {
    Variables.audioPlayer.stop();

    if (heads.isNotEmpty) {
      int index = 0;

      final mediaItems = heads.map(
        (song) {
          String audioUrl =
              'https://tingla.pixer.uz/audio/${song.audios![0].audioFile!.fileId}.${song.audios![0].audioFile!.type}?ssid=${Variables.userToken}';

          index = (index % heads.length) + 1;
          return MediaItem(
            id: index.toString(),
            artUri: Uri.parse(book.data!.bookPhoto ?? ''),
            title: song.title ?? '',
            extras: {'url': audioUrl},
          );
        },
      ).toList();

      if (Variables.audioPlayer.queue.value.isEmpty) {
        await Variables.audioPlayer.addQueueItems(mediaItems);
      } else {
        await _updateQueue(mediaItems);
      }

      currentBook = book;
    } else {
      final mediaItems = List.generate(5, (index) {
        return MediaItem(
          id: index.toString(),
          artUri: Uri.parse('https://source.unsplash.com/random/$index'),
          title: '$index alu',
          extras: {
            'url':
                'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-$index.mp3'
          },
        );
      });

      if (Variables.audioPlayer.queue.value.isEmpty) {
        await Variables.audioPlayer.addQueueItems(mediaItems);
      } else {
        await _updateQueue(mediaItems);
      }

      currentBook = book;
    }
  }

  Future<void> _updateQueue(List<MediaItem> mediaItems) async {
    for (MediaItem item in Variables.audioPlayer.queue.value) {
      Variables.audioPlayer.removeQueueItem(item);
    }
    await Variables.audioPlayer.addQueueItems(mediaItems);
  }

  void _listenToPlaybackState() {
    Variables.audioPlayer.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        buttonState = ButtonState.loading;
      } else if (!isPlaying) {
        buttonState = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        buttonState = ButtonState.playing;
      } else {
        Variables.audioPlayer.seek(Duration.zero);
        Variables.audioPlayer.pause();
      }

      notifyListeners();
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressBarState;
      progressBarState = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );

      notifyListeners();
    });
  }

  void _listenToBufferedPosition() {
    Variables.audioPlayer.playbackState.listen((playbackState) {
      final oldState = progressBarState;
      progressBarState = ProgressBarState(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );

      notifyListeners();
    });
  }

  void _listenToTotalDuration() {
    Variables.audioPlayer.mediaItem.listen((mediaItem) {
      final oldState = progressBarState;
      progressBarState = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );

      notifyListeners();
    });
  }

  void _listenToChangesInSong() {
    Variables.audioPlayer.mediaItem.listen((mediaItem) {
      currentSong = mediaItem;
    });

    notifyListeners();
  }

  void play() => Variables.audioPlayer.play();

  void pause() => Variables.audioPlayer.pause();

  void seek(Duration position) => Variables.audioPlayer.seek(position);

  void previous() => Variables.audioPlayer.skipToPrevious();
  void next() => Variables.audioPlayer.skipToNext();

  void skipToBack() {
    if (progressBarState.current.inSeconds - 15 <= 0) {
      seek(Duration.zero);
    } else {
      seek(Duration(seconds: progressBarState.current.inSeconds - 15));
    }
  }

  void skipToNext() {
    if (progressBarState.current.inSeconds + 15 >=
        progressBarState.total.inSeconds) {
      seek(progressBarState.total);
    } else {
      seek(Duration(seconds: progressBarState.current.inSeconds + 15));
    }
  }
}
