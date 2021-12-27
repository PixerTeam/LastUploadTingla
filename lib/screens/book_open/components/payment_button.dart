import 'package:flutter/material.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/size_config.dart';

class PaymentButton extends StatelessWidget {
  final active;
  final title;
  final image;
  final index;
  final press;

  const PaymentButton({
    Key? key,
    this.active,
    this.title,
    this.image,
    this.index,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionScreenHeight(12.0),
        horizontal: getProportionScreenWidth(16.0),
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: active == index
              ? const Color(0xFF0F0F54)
              : kTextColor.withOpacity(.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: kTextColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
          SizedBox(height: getProportionScreenHeight(16.0)),
          Container(
            width: getProportionScreenWidth(100.0),
            height: getProportionScreenHeight(44.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image,
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
          SizedBox(height: getProportionScreenHeight(3.0)),
        ],
      ),
    );
  }
}
