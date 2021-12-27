import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/custom_app_bar.dart';

import 'components/body.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Body(),
          CustomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: getProportionScreenWidth(8.0),
                ),
                SizedBox(
                  width: getProportionScreenWidth(120.0),
                  height: getProportionScreenWidth(36.0),
                  child: SvgPicture.asset('assets/icons/emblem_with_text_icon.svg'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
