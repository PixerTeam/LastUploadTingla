import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/size_config.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final String text;
  const CustomExpansionTile({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      elevation: 0.0,
      shadowColor: Colors.transparent,
      baseColor: Colors.transparent,
      expandedTextColor: Colors.black,
      expandedColor: Colors.transparent,
      finalPadding: EdgeInsets.zero,
      initialPadding: EdgeInsets.zero,
      trailing: SvgPicture.asset(
        'assets/icons/bottom_icon.svg',
        width: getProportionScreenWidth(18.0),
        color: Colors.black,
      ),
      animateTrailing: true,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextStyle(
          fontSize: getProportionScreenWidth(18.0),
          fontWeight: FontWeight.w400,
        ),
      ),
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            fontSize: getProportionScreenWidth(16.0),
            color: kTextColor.withOpacity(.6),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
