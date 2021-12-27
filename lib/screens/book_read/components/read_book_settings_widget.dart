import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/variables/book_theme.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/custom_slider_widget.dart';

import 'change_background_button.dart';
import 'change_font_size_button.dart';

class ReadBookSettingsWidget extends StatefulWidget {
  final callback;
  const ReadBookSettingsWidget({Key? key, this.callback}) : super(key: key);

  @override
  _ReadBookSettingsWidgetState createState() => _ReadBookSettingsWidgetState();
}

class _ReadBookSettingsWidgetState extends State<ReadBookSettingsWidget> {
  double _brightness = 1.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.symmetric(
            vertical: getProportionScreenWidth(16.0),
            horizontal: getProportionScreenHeight(24.0),
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
                "Yorqinlik",
                style: TextStyle(
                  fontSize: getProportionScreenWidth(16.0),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: getProportionScreenHeight(16.0),
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/sun_icon.svg',
                  ),
                  SizedBox(
                    width: getProportionScreenWidth(12.0),
                  ),
                  Expanded(
                    child: CustomSliderWidget(
                      minValue: 0.0,
                      maxValue: 100.0,
                      value: _brightness,
                      onChanged: (value) {
                        setState(() {
                          _brightness = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: getProportionScreenWidth(12.0),
                  ),
                  SvgPicture.asset('assets/icons/sun_black_icon.svg',
                  ),
                ],
              ),
              SizedBox(
                height: getProportionScreenHeight(32.0),
              ),
              Text(
                "Orqa fon rangi",
                style: TextStyle(
                  fontSize: getProportionScreenWidth(16.0),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: getProportionScreenHeight(16.0),
              ),
              Row(
                children: [
                  ChangeBackgroundButton(
                    backgroundColor: Colors.white,
                    title: "Aa",
                    press: () {
                      widget.callback(tag: "light");
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  ChangeBackgroundButton(
                    backgroundColor: Colors.black,
                    title: "Aa",
                    press: () {
                      widget.callback(tag: "dark");
                      setState(() {});
                    },
                  ),
                ],
              ),
              SizedBox(
                height: getProportionScreenHeight(32.0),
              ),
              Text(
                "Shrift kattaligi",
                style: TextStyle(
                  fontSize: getProportionScreenWidth(16.0),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: getProportionScreenHeight(16.0),
              ),
              Row(
                children: [
                  ChangeFontSizeButton(
                    title: "Aa-",
                    press: () {
                      if (BookTheme.fontSize - 1 != 16.0) {
                        widget.callback(size: --BookTheme.fontSize);
                      }
                    },
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  ChangeFontSizeButton(
                    title: "Aa+",
                    press: () {
                      if (BookTheme.fontSize + 1 != 24.0) {
                        widget.callback(size: ++BookTheme.fontSize);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
