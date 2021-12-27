import 'package:flutter/material.dart';
import 'package:tingla/screens/auth/check_phone_screen.dart';
import 'package:tingla/size_config.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionScreenWidth(24.0)),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Rectangle 1 (1).png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              child: Text(
                "Haqiqiy quvonchni\nkashf eting",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: getProportionScreenWidth(36.0),
                  fontWeight: FontWeight.w800,
                  height: 1.4,
                  letterSpacing: -0.1,
                ),
              ),
            ),
            SizedBox(height: getProportionScreenHeight(12.0)),
            Text(
              "Dunyoga mashhur, bestseller asarlarning audio kitoblarini istalgan vaqtda, istalgan joyda audio tarzda tinglashingiz va elektron kitob shaklida o’qishingiz mumkin. Ro’yxatdan o’ting va zavqlaning.",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                height: 1.8,
                fontSize: getProportionScreenWidth(16.0),
              ),
            ),
            SizedBox(height: getProportionScreenHeight(50.0)),
            SizedBox(
              height: getProportionScreenHeight(60.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const CheckPhoneNumberScreen(),
                    ),
                  );
                },
                child: Text(
                  "Ro'yxatdan o'tish",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.1,
                    fontSize: getProportionScreenWidth(20.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getProportionScreenHeight(50.0),
            ),
          ],
        ),
      ),
    );
  }
}
