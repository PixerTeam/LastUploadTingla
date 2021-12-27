import 'package:flutter/material.dart';
import 'package:tingla/size_config.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontFamily: 'SFProDisplay',
        fontSize: getProportionScreenWidth(20.0),
        fontStyle: FontStyle.normal,
      ),
      bodyText2: TextStyle(
        fontFamily: 'SFProDisplay',
        fontSize: getProportionScreenWidth(20.0),
        fontStyle: FontStyle.normal,
      ),
      button: const TextStyle(
        fontFamily: 'SFProDisplay',
        fontSize: 18.0,
        fontStyle: FontStyle.normal,
      ),
      caption: const TextStyle(
        fontFamily: 'SFProDisplay',
        fontSize: 18.0,
        fontStyle: FontStyle.normal,
      ),
    ),
  );
}
