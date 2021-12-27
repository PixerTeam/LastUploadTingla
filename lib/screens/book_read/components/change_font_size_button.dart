import 'package:flutter/material.dart';
import 'package:tingla/size_config.dart';

class ChangeFontSizeButton extends StatelessWidget {
  final title;
  final press;

  const ChangeFontSizeButton({
    Key? key,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          padding: EdgeInsets.symmetric(
            horizontal: getProportionScreenWidth(16.0),
            vertical: getProportionScreenHeight(13.0),
          ),
          primary: const Color(0xFFF2F2F2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        onPressed: press,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionScreenWidth(20.0),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
