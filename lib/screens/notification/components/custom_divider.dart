import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tingla/size_config.dart';


class CustomDivider extends StatelessWidget {
  final title;
  const CustomDivider({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getProportionScreenWidth(24.0)),
      margin: EdgeInsets.only(bottom: getProportionScreenHeight(13.0)),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: Divider(
              color: Colors.black,
            ),
          ),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: getProportionScreenWidth(12)),
            child: Text(
              title,
              style: TextStyle(fontSize: getProportionScreenWidth(18)),
            ),
          ),
          const Expanded(
            child: Divider(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
