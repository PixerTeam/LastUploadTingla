import 'package:flutter/material.dart';
import 'package:tingla/variables/book_theme.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/book_control.dart';
import 'package:tingla/widgets/custom_slider_widget.dart';

class CustomBottomSlider extends StatelessWidget {
  final BookControl bookControl;
  const CustomBottomSlider({
    Key? key,
    required this.bookControl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.only(
        top: getProportionScreenHeight(32.0),
        left: getProportionScreenWidth(24.0),
        right: getProportionScreenWidth(24.0),
        bottom: getProportionScreenHeight(24.0),
      ),
      decoration: BoxDecoration(
        color: BookTheme.backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: BookTheme.textColor.withOpacity(.3),
            offset: const Offset(0, 5),
            blurRadius: 30.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueListenableBuilder<BookControlState>(
            valueListenable: bookControl.progressNotifier,
            builder: (_, value, __) {
              return CustomSliderWidget(
                minValue: 0.0,
                maxValue: value.total,
                value: value.current,
                onChanged: (double value) {
                  bookControl.isSlider = true;
                  bookControl.scrollController!.jumpTo(value);
                  bookControl.isSlider = false;
                },
                color: BookTheme.textColor,
              );
            },
          ),
          const SizedBox(height: 12.0),
          ValueListenableBuilder<BookControlState>(
            valueListenable: bookControl.progressNotifier,
            builder: (_, value, __) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (value.current.round() / SizeConfig.screenHeight!).round().toString(),
                    style: TextStyle(
                      color: BookTheme.textColor,
                      fontSize: getProportionScreenWidth(20.0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " / ${(value.total.round() / SizeConfig.screenHeight!).round()}",
                    style: TextStyle(
                      color: BookTheme.textColor,
                      fontSize: getProportionScreenWidth(20.0),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
