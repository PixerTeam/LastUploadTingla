import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/model/notifiers/play_button_notifier.dart';
import 'package:tingla/model/page_manager.dart';
import 'package:tingla/model/services/service_locator.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/custom_button.dart';

class AudioListWidget extends StatelessWidget {
  final String title;
  const AudioListWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight! / 2,
            ),
          ),
          Container(
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(
              horizontal: getProportionScreenHeight(24.0),
              vertical: getProportionScreenWidth(16.0),
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: SizedBox(
                    width: getProportionScreenWidth(60.0),
                    child: const Divider(
                      height: 0,
                      thickness: 2.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: getProportionScreenWidth(24.0),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: getProportionScreenHeight(27.0),
                ),
                ValueListenableBuilder(
                  valueListenable: pageManager.playlistNotifier,
                  builder: (_, List<MediaItem> playlist, __) {
                    return Column(
                      children: List.generate(playlist.length, (index) {
                        Duration duration = playlist[index].duration!;

                        int intMinute = duration.inMinutes % 60;
                        int intSecond = duration.inSeconds % 60;
                        
                        String minute = intMinute < 10 ? '0' + intMinute.toString() : intMinute.toString();
                        String seconds = intSecond < 10 ? '0' + intSecond.toString() : intSecond.toString();

                        String audioDuration = minute + ':' + seconds;

                        return Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${playlist[index].id}-bob. ",
                                  style: TextStyle(
                                    fontSize: getProportionScreenWidth(20.0),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    playlist[index].title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: getProportionScreenWidth(20.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionScreenWidth(13.0),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ValueListenableBuilder<ButtonState>(
                                    valueListenable:
                                        pageManager.playButtonNotifier,
                                    builder: (_, ButtonState value, __) {
                                      return ValueListenableBuilder<MediaItem?>(
                                        valueListenable:
                                            pageManager.currentSongNotifier,
                                        builder: (_, MediaItem? item, __) {
                                          if (item == null ||
                                              item.id != playlist[index].id) {
                                            return CustomButton(
                                              color: const Color(0xFF3243DC),
                                              icon:
                                                  'assets/icons/audio_play_icon.svg',
                                              press: () async {
                                                pageManager
                                                    .skipToQueueItem(index);
                                                pageManager.play();
                                              },
                                            );
                                          }

                                          switch (value) {
                                            case ButtonState.playing:
                                              return CustomButton(
                                                color: const Color(0xFF3243DC),
                                                icon: 'assets/icons/audio_pause_icon.svg',
                                                press: pageManager.pause,
                                              );
                                            case ButtonState.paused:
                                              return CustomButton(
                                                color: const Color(0xFF3243DC),
                                                icon:
                                                    'assets/icons/audio_play_icon.svg',
                                                press: pageManager.play,
                                              );
                                            case ButtonState.loading:
                                              return CustomButton(
                                                color: const Color(0xFF3243DC),
                                                icon:
                                                    'assets/icons/audio_pause_icon.svg',
                                              );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    audioDuration,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: kTextColor.withOpacity(.5),
                                      fontSize: getProportionScreenWidth(14.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getProportionScreenHeight(12.0),
                            ),
                          ],
                        );
                      }),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
