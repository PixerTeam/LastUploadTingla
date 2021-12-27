import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/variables/book_theme.dart';
import 'package:tingla/size_config.dart';

class ChangeBackgroundButton extends StatelessWidget {
  final backgroundColor;
  final title;
  final press;

  const ChangeBackgroundButton({
    Key? key,
    this.backgroundColor,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionScreenWidth(16.0),
            vertical: getProportionScreenHeight(13.0),
          ),
          primary: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(
              color: BookTheme.themeMode ? Colors.black : Colors.transparent, // Color(0xFF3243DC)
            ),
          ),
        ),
        onPressed: press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('assets/icons/check_icon1.svg',
              color: BookTheme.themeMode ? Colors.black : Colors.white, //  Color(0xFF00A538)
              width: getProportionScreenWidth(18.0),
            ),
            Text(
              "Aa",
              style: TextStyle(
                color: backgroundColor == Colors.black
                    ? Colors.white
                    : Colors.black,
                fontSize: getProportionScreenWidth(20.0),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              width: getProportionScreenWidth(24.0),
              height: getProportionScreenHeight(24.0),
            ),
          ],
        ),
      ),
    );
  }
}
