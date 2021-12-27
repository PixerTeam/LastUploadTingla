import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tingla/size_config.dart';

class DownloadNotScreen extends StatelessWidget {
  const DownloadNotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: getProportionScreenHeight(153.0),
          child: SvgPicture.asset("assets/icons/download_image.svg"),
          width: getProportionScreenWidth(240.0),
        ),
        SizedBox(
          height: getProportionScreenHeight(30.0),
        ),
        Text(
          "Yuklangan kitoblar yo’q.\nAmmo kitoblarni yuklab olishingiz mumkin",
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
