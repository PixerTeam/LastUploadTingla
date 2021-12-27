import 'package:flutter/material.dart';
import 'package:tingla/model/page_manager.dart';
import 'package:tingla/model/services/service_locator.dart';
import 'package:tingla/size_config.dart';

import 'audio_player_settings.dart';

class AudioSpeedWidget extends StatelessWidget {
  const AudioSpeedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    
    return ValueListenableBuilder<double>(
        valueListenable: pageManager.currentSpeedNotifier,
        builder: (_, double speed, __) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => AudioPlayerSettings(
                  currentSpeed: speed,
                ),
              );
            },
            child: Container(
              height: getProportionScreenHeight(24.0),
              padding: EdgeInsets.symmetric(
                horizontal: getProportionScreenWidth(2.0),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Center(
                child: Text(
                  "${speed}x",
                  style: TextStyle(
                    fontSize: getProportionScreenWidth(14.0),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
