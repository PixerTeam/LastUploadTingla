import 'package:flutter/material.dart';
import 'package:tingla/schema/cache_book_schema.dart';

class AudioControlState {
  AudioControlState({
    required this.current,
    required this.total,
  });
  final int current;
  final int total;
}

class AudioControl {
  int headIndex = 0;

  ValueNotifier<AudioControlState> progressNotifier =
      ValueNotifier<AudioControlState>(
    AudioControlState(current: 0, total: 0),
  );

  void setAudioState(CacheBook cache) async {
    headIndex = cache.headIndex;

    progressNotifier.value = AudioControlState(
      current: cache.audioCurrentOffset,
      total: cache.audioMaxOffset,
    );
  }
}
