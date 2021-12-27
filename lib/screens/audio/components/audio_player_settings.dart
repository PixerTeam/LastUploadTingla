import 'package:flutter/material.dart';
import 'package:tingla/model/page_manager.dart';
import 'package:tingla/model/services/service_locator.dart';
import 'package:tingla/size_config.dart';

class AudioPlayerSettings extends StatefulWidget {
  final double currentSpeed;
  const AudioPlayerSettings({Key? key, required this.currentSpeed})
      : super(key: key);

  @override
  _AudioPlayerSettingsState createState() => _AudioPlayerSettingsState();
}

class _AudioPlayerSettingsState extends State<AudioPlayerSettings> {
  double changeSpeed = 1.0;
  @override
  void initState() {
    if (widget.currentSpeed == 0.2) {
      changeSpeed = 0.0;
    } else {
      changeSpeed = widget.currentSpeed;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Column(
      children: [
        const Spacer(),
        Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.symmetric(
            vertical: getProportionScreenHeight(16.0),
            horizontal: getProportionScreenWidth(24.0),
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
                "Ovoz tezligi",
                style: TextStyle(
                  fontSize: getProportionScreenWidth(16.0),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: getProportionScreenHeight(20.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionScreenWidth(14.0)),
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: getProportionScreenHeight(3.0),
                    trackShape: const RectangularSliderTrackShape(),
                    activeTrackColor: const Color(0xFFC4C4C4),
                    inactiveTrackColor: const Color(0xFFC4C4C4),
                    overlayShape: SliderComponentShape.noOverlay,
                    thumbColor: Colors.black,
                    activeTickMarkColor: const Color(0xFFC4C4C4),
                    inactiveTickMarkColor: const Color(0xFFC4C4C4),
                    tickMarkShape: RoundSliderTickMarkShape(
                      tickMarkRadius: getProportionScreenHeight(4.0),
                    ),
                  ),
                  child: Slider(
                    min: 0.0,
                    max: 2.0,
                    value: changeSpeed,
                    divisions: 4,
                    onChanged: (value) {
                      if (value == 0.0) {
                        changeSpeed = 0.2;
                      } else {
                        changeSpeed = value;
                      }

                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: getProportionScreenHeight(14.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          changeSpeed = 0.0;

                          setState(() {});
                        },
                        child: Column(
                          children: [
                            Text(
                              "0.2x",
                              style: TextStyle(
                                color: changeSpeed == 0.0
                                    ? Colors.black
                                    : Colors.black.withOpacity(.4),
                                fontSize: getProportionScreenWidth(16.0),
                              ),
                            ),
                            Text(
                              "Juda sekin",
                              style: TextStyle(
                                color: changeSpeed == 0.0
                                    ? Colors.black
                                    : Colors.black.withOpacity(.4),
                                fontSize: getProportionScreenWidth(14.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: getProportionScreenWidth(8.0)),
                      child: GestureDetector(
                        onTap: () {
                          changeSpeed = 0.5;

                          setState(() {});
                        },
                        child: Column(
                          children: [
                            Text(
                              "0.5x",
                              style: TextStyle(
                                color: changeSpeed == 0.5
                                    ? Colors.black
                                    : Colors.black.withOpacity(.4),
                                fontSize: getProportionScreenWidth(16.0),
                              ),
                            ),
                            Text(
                              "Sekin",
                              style: TextStyle(
                                color: changeSpeed == 0.5
                                    ? Colors.black
                                    : Colors.black.withOpacity(.4),
                                fontSize: getProportionScreenWidth(14.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        changeSpeed = 1.0;

                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Text(
                            "1.0x",
                            style: TextStyle(
                              color: changeSpeed == 1.0
                                  ? Colors.black
                                  : Colors.black.withOpacity(.4),
                              fontSize: getProportionScreenWidth(16.0),
                            ),
                          ),
                          Text(
                            "Normal",
                            style: TextStyle(
                              color: changeSpeed == 1.0
                                  ? Colors.black
                                  : Colors.black.withOpacity(.4),
                              fontSize: getProportionScreenWidth(14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: getProportionScreenWidth(8.0)),
                      child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            changeSpeed = 1.5;

                            setState(() {});
                          },
                          child: Column(
                            children: [
                              Text(
                                "1.5x",
                                style: TextStyle(
                                  color: changeSpeed == 1.5
                                      ? Colors.black
                                      : Colors.black.withOpacity(.4),
                                  fontSize: getProportionScreenWidth(16.0),
                                ),
                              ),
                              Text(
                                "Tez",
                                style: TextStyle(
                                  color: changeSpeed == 1.5
                                      ? Colors.black
                                      : Colors.black.withOpacity(.4),
                                  fontSize: getProportionScreenWidth(14.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          changeSpeed = 2.0;

                          setState(() {});
                        },
                        child: Column(
                          children: [
                            Text(
                              "2.0x",
                              style: TextStyle(
                                color: changeSpeed == 2
                                    ? Colors.black
                                    : Colors.black.withOpacity(.4),
                                fontSize: getProportionScreenWidth(16.0),
                              ),
                            ),
                            Text(
                              "Juda tez",
                              style: TextStyle(
                                color: changeSpeed == 2
                                    ? Colors.black
                                    : Colors.black.withOpacity(.4),
                                fontSize: getProportionScreenWidth(14.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getProportionScreenHeight(30.0),
              ),
              SizedBox(
                height: getProportionScreenHeight(60.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF0F0F54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    if (changeSpeed == 0.0) {
                      pageManager.setSpeed(0.2);
                    } else {
                      pageManager.setSpeed(changeSpeed);
                    }

                    Navigator.pop(context);
                  },
                  child: Text(
                    "Qo'llash",
                    style: TextStyle(
                      fontSize: getProportionScreenWidth(20.0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
