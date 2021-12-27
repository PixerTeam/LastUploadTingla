import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/size_config.dart';

class SplashScreen extends StatelessWidget {
  final Widget? child;
  const SplashScreen({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (child != null) {
      Future.delayed(
        const Duration(seconds: 3),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => child!),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(15, 15, 84, 1),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionScreenWidth(28.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(getProportionScreenWidth(16.0)),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/icons/splash_back_icon.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              height: getProportionScreenHeight(182.0),
              child: SizedBox(
                child: SvgPicture.asset("assets/icons/splash_logo_icon.svg"),
                height: getProportionScreenHeight(123.0),
                width: getProportionScreenWidth(123.0),
              ),
            ),
            SizedBox(
              height: getProportionScreenHeight(8.0),
            ),
            SizedBox(
              child: SvgPicture.asset("assets/icons/logo_text_icon.svg"),
              height: getProportionScreenHeight(37.13),
              width: getProportionScreenWidth(125.05),
            ),
            SizedBox(
              height: getProportionScreenHeight(22.0),
            ),
            Text(
              "Endi har lahza unumli",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getProportionScreenWidth(18.0),
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
