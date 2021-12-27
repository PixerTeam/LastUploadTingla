import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/size_config.dart';

class CustomBigButton extends StatelessWidget {
  final icon;
  final text;
  final backgroundColor;
  final press;

  const CustomBigButton({
    Key? key,
    this.icon,
    this.text,
    this.backgroundColor,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: getProportionScreenHeight(60.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          onPressed: press,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                height: getProportionScreenWidth(24.0),
                width: getProportionScreenWidth(24.0),
              ),
              SizedBox(
                width: getProportionScreenWidth(6.0),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: getProportionScreenWidth(20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
