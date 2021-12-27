import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tingla/model/notifiers/play_button_notifier.dart';
import 'package:tingla/model/page_manager.dart';
import 'package:tingla/model/services/service_locator.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/custom_button.dart';

class AudioBottomButtons extends StatelessWidget {
  const AudioBottomButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomButton(
          icon: 'assets/icons/skip_back_icon.svg',
          press: pageManager.skipToBack,
          color: Colors.black,
          size: 30.0,
        ),
        CustomButton(
          icon: 'assets/icons/audio_back_icon.svg',
          press: pageManager.previous,
          color: Colors.black,
          size: 30.0,
        ),
        ValueListenableBuilder<ButtonState>(
          valueListenable: pageManager.playButtonNotifier,
          builder: (_, ButtonState value, __) {
            
            switch (value) {
              case ButtonState.loading:
                return buildButton(
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  state: value,
                );
              case ButtonState.paused:
                return buildButton(
                  child: Icon(
                    CupertinoIcons.play_fill,
                    color: Colors.white,
                    size: getProportionScreenWidth(30.0),
                  ),
                  onTap: pageManager.play,
                  state: value,
                );
              case ButtonState.playing:
                return buildButton(
                  child: Icon(
                    CupertinoIcons.pause_fill,
                    color: Colors.white,
                    size: getProportionScreenWidth(30.0),
                  ),
                  onTap: pageManager.pause,
                  state: value,
                );
            }
          },
        ),
        CustomButton(
          icon: 'assets/icons/audio_next_icon.svg',
          press: pageManager.next,
          color: Colors.black,
          size: 30.0,
        ),
        CustomButton(
          icon: 'assets/icons/skip_next_icon.svg',
          press: pageManager.skipToNext,
          color: Colors.black,
          size: 30.0,
        ),
      ],
    );
  }

  Widget buildButton({onTap, child, state}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: getProportionScreenWidth(78.0),
        height: getProportionScreenHeight(78.0),
        padding: EdgeInsets.only(
          left:
              state == ButtonState.paused ? getProportionScreenWidth(6.0) : 0.0,
        ),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
