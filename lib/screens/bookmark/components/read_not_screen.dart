import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/size_config.dart';

class ReadNotScreen extends StatelessWidget {
  const ReadNotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: getProportionScreenHeight(153.0),
          child: SvgPicture.asset("assets/icons/read_book_image.svg"),
          width: getProportionScreenWidth(240.0),
        ),
        SizedBox(
          height: getProportionScreenHeight(30.0),
        ),
        Text(
          "O'qilayotgan kitoblar yo'q.\nAmmo kitoblarni o'qishingiz va tinglashingiz mumkin",
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.8,
            fontSize: getProportionScreenWidth(16.0),
          ),
        ),
        SizedBox(
          height: getProportionScreenHeight(85.0),
        ),
      ],
    );
  }
}
