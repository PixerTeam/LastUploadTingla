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
    this.image, this.index, this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: getProportionScreenHeight(12.0),
              horizontal: getProportionScreenWidth(16.0),
            ),
            primary: Colors.transparent,
            elevation: 0.0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: active == index ? const Color(0xFF0F0F54) : kTextColor.withOpacity(.2),
              ),
            ),
          ),
          onPressed: press,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: kTextColor,
                  fontSize: getProportionScreenWidth(14.0),
                  fontWeight: FontWeight.bold,
                  // height: getProportionScreenHeight(1.8),
                  height: 1.8,
                ),
              ),
              SizedBox(height: getProportionScreenHeight(16.0)),
              Container(
                width: getProportionScreenWidth(64.0),
                height: getProportionScreenHeight(24.0),
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
        ),
      ),
    );
  }
}
