import 'package:flutter/material.dart';
import 'package:tingla/size_config.dart';


class RatingFilterButton extends StatelessWidget {
  final press;
  final child;
  final active;
  final width;
  final height;

  const RatingFilterButton({
    Key? key,
    this.press,
    required this.child,
    this.active,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionScreenHeight(height ?? 42.0),
      width: getProportionScreenWidth(width ?? 76.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: active ?? false ? const Color(0xFF0F0F54) : const Color(0xFFF5F5F5),
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        onPressed: press ?? () {},
        child: child,
      ),
    );
  }
}
