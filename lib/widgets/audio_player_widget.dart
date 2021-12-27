import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/model/notifiers/play_button_notifier.dart';
import 'package:tingla/model/page_manager.dart';
import 'package:tingla/model/services/service_locator.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/screens/audio/network_audio_player/network_audio_player_screen.dart';
import 'package:tingla/screens/audio/local_audio_player/local_audio_player_screen.dart';

import 'custom_button.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder(
      valueListenable: pageManager.audioActiveNotifier,
      builder: (_, bool active, __) {
        if (active) {
          return Dismissible(
            key: Key(pageManager.currentBookId.toString()),
            onDismissed: (direction) async {
              pageManager.stop();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionScreenWidth(24.0),
                vertical: getProportionScreenHeight(20.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 50.0,
                    sigmaY: 50.0,
                  ),
                  child: Container(
                    width: SizeConfig.screenWidth! -
                        getProportionScreenWidth(48.0),
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionScreenWidth(14.0),
                      horizontal: getProportionScreenWidth(20.0),
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(215, 215, 215, 0.7),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (pageManager.currentBookId != null) {
                                if (pageManager.currentBookId![0] != 'n') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LocalAudioPlayerScreen(
                                        book: pageManager.currentBook,
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AudioPlayerScreen(
                                        book: pageManager.currentBook,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: ValueListenableBuilder(
                              valueListenable: pageManager.currentSongNotifier,
                              builder: (_, MediaItem? item, __) {
                                if (item != null) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize:
                                              getProportionScreenWidth(16.0),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        '${item.id}-bob',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: kTextColor.withOpacity(.6),
                                          fontSize:
                                              getProportionScreenWidth(14.0),
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                return Text(
                                  'Yuklanmoqda',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: getProportionScreenWidth(16.0),
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getProportionScreenWidth(13.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                              icon: 'assets/icons/audio_back_icon.svg',
                              color: Colors.black,
                              size: getProportionScreenWidth(22.0),
                              press: pageManager.previous,
                            ),
                            ValueListenableBuilder<ButtonState>(
                              valueListenable: pageManager.playButtonNotifier,
                              builder: (_, ButtonState value, __) {
                                switch (value) {
                                  case ButtonState.loading:
                                    return Container(
                                      width: getProportionScreenWidth(29.0),
                                      height: getProportionScreenWidth(28.0),
                                      margin: EdgeInsets.symmetric(
                                          horizontal:
                                              getProportionScreenWidth(8.0)),
                                      alignment: Alignment.center,
                                      child: const CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    );
                                  case ButtonState.paused:
                                    return GestureDetector(
                                      onTap: pageManager.play,
                                      child: Container(
                                        width: getProportionScreenWidth(45.0),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                            left:
                                                getProportionScreenWidth(8.0)),
                                        child: Icon(
                                          CupertinoIcons.play_fill,
                                          color: Colors.black,
                                          size: getProportionScreenWidth(24.0),
                                        ),
                                      ),
                                    );
                                  case ButtonState.playing:
                                    return GestureDetector(
                                      onTap: pageManager.pause,
                                      child: Container(
                                        width: getProportionScreenWidth(45.0),
                                        alignment: Alignment.center,
                                        child: Icon(
                                          CupertinoIcons.pause_fill,
                                          color: Colors.black,
                                          size: getProportionScreenWidth(24.0),
                                        ),
                                      ),
                                    );
                                }
                              },
                            ),
                            CustomButton(
                              icon: 'assets/icons/audio_next_icon.svg',
                              color: Colors.black,
                              size: getProportionScreenWidth(22.0),
                              press: pageManager.next,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
