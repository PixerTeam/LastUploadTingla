import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tingla/size_config.dart';

class HasNotBody extends StatelessWidget {
  const HasNotBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: getProportionScreenWidth(194),
            height: getProportionScreenWidth(126),
            child: SvgPicture.asset("assets/icons/not_image_icon.svg"),
          ),
          SizedBox(height: getProportionScreenHeight(40.0)),
          Text(
            "Bildirishnomalar yo'q",
            style: TextStyle(
              fontSize: getProportionScreenWidth(18.0),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
