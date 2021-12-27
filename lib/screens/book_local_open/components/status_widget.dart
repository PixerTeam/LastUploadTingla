
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/size_config.dart';

class StatusWidget extends StatelessWidget {
  final icon;
  final title;
  final text;
  final press;

  const StatusWidget({
    Key? key,
    this.icon,
    this.title,
    this.text, this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: getProportionScreenWidth(15.0)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: getProportionScreenWidth(56.0),
                  height: getProportionScreenHeight(56.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(.1),
                  ),
                  child: SvgPicture.asset(
                    icon,
                  ),
                ),
                SizedBox(width: getProportionScreenWidth(20.0)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: getProportionScreenWidth(16.0),
                          color: Colors.black.withOpacity(.6),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: getProportionScreenWidth(24.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
