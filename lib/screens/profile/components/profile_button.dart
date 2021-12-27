import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/size_config.dart';

class CustomSwitchWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String leading;
  final Widget? trailing;
  final VoidCallback? press;
  final double? height;

  const CustomSwitchWidget({
    Key? key,
    required this.title,
    required this.leading,
    this.subtitle,
    //
    this.trailing,
    this.press,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: press ?? () {},
      child: SizedBox(
        height: getProportionScreenHeight(height ?? 72.0),
        child: Row(
          children: [
            SizedBox(
              width: getProportionScreenWidth(24.0),
              height: getProportionScreenWidth(24.0),
              child: SvgPicture.asset(
                leading,
              ),
            ),
            SizedBox(width: getProportionScreenWidth(16.0)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: getProportionScreenWidth(18.0),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (subtitle != null)
                    Column(
                      children: [
                        SizedBox(height: getProportionScreenHeight(4.0)),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: getProportionScreenWidth(14.0),
                            color: kTextColor.withOpacity(.5),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            trailing ??
                SizedBox(
                  width: getProportionScreenWidth(18.0),
                  height: getProportionScreenWidth(18.0),
                  child: SvgPicture.asset(
                    'assets/icons/cupertino_next_icon.svg',
                    color: Colors.black,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
