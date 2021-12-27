import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:tingla/model/notifiers/progress_notifier.dart';
import 'package:tingla/model/page_manager.dart';
import 'package:tingla/model/services/service_locator.dart';
import 'package:tingla/size_config.dart';

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, ProgressBarState value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: pageManager.seek,
          thumbGlowRadius: getProportionScreenHeight(28.0),
          thumbRadius: getProportionScreenHeight(22.0 / 2.0),
          barHeight: getProportionScreenHeight(6.0),
          timeLabelPadding: getProportionScreenHeight(14.0),
          timeLabelTextStyle: TextStyle(
            color: Colors.black.withOpacity(.5),
            fontSize: getProportionScreenWidth(14.0),
          ),
          thumbColor: Colors.black,
          progressBarColor: Colors.black,
          bufferedBarColor: Colors.black.withOpacity(.3),
          baseBarColor: Colors.black.withOpacity(.1),
        );
      },
    );
  }
}
