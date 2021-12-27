import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/size_config.dart';

class ShowDialogWidget extends StatelessWidget {
  const ShowDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(getProportionScreenWidth(30.0)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(getProportionScreenWidth(20.0)),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE1F4E5),
              ),
              child: SvgPicture.asset('assets/icons/complect_icon.svg',
                color: const Color(0xFF4FBF67),
                width: getProportionScreenWidth(30.0),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              "To’lovingiz muvaffaqiyatli\nqabul qilindi",
              style: TextStyle(
                fontSize: getProportionScreenWidth(20.0),
                fontWeight: FontWeight.bold,
                height: getProportionScreenHeight(2.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
