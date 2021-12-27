import 'package:flutter/material.dart';
import 'package:tingla/size_config.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFFFFFFF),
        child: Column(
          children: [
            Container(
              height: getProportionScreenHeight(400.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/images/network_error_image.png"),
                ),
              ),
            ),
            Text(
              "Oh no!",
              style: TextStyle(fontSize: getProportionScreenWidth(24.0)),
            ),
            Container(
              padding: EdgeInsets.all(getProportionScreenHeight(20.0)),
              child: Text(
                "No Internet found. Check your connection or try again,",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: getProportionScreenWidth(20.0)),
              ),
            ),
            // OutlinedButton(
            //   onPressed: press,
            //   child: Text("TRY AGAIN"),
            // ),
          ],
        ),
      ),
    );
  }
}
