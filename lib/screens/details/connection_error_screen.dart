import 'package:flutter/material.dart';
import 'package:tingla/size_config.dart';

class ConnectionErrorScreen extends StatelessWidget {
  final press;
  const ConnectionErrorScreen({
    Key? key,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: getProportionScreenHeight(136.0),
          ),
          Image.asset("assets/images/network_error_image.png"),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("assets/images/network_error_image.png"),
              ),
              color: Colors.red,
            ),
          ),
          Text(
            "Xato!",
            style: TextStyle(
              fontSize: getProportionScreenWidth(24.0),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: getProportionScreenHeight(20.0)),
            child: Text(
              "Internet topilmadi! Iltimos internetingizni\ntekshirib yana urinib ko'ring.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getProportionScreenWidth(20.0),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              primary: const Color.fromRGBO(15, 15, 84, 1),
            ),
            onPressed: press,
            child: Text(
              "YANA BOG'LANISH",
              style: TextStyle(
                color: Colors.white,
                fontSize: getProportionScreenWidth(20.0),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
