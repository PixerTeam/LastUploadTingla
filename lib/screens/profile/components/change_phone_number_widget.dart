import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/custom_button.dart';

// ignore: must_be_immutable
class ChangeNumberWidget extends StatelessWidget {
  String? _phone;
  ChangeNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: getProportionScreenWidth(24.0),
                right: getProportionScreenWidth(24.0),
                bottom: getProportionScreenHeight(16.0),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 70.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionScreenWidth(20.0),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/phone_icon.svg',
                          width: getProportionScreenWidth(24.0),
                        ),
                        SizedBox(
                          width: getProportionScreenWidth(15.0),
                        ),
                        Text(
                          "(+998) ",
                          style: TextStyle(
                            fontSize: getProportionScreenWidth(18.0),
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            cursorColor: Colors.black,
                            cursorWidth: 1.0,
                            maxLength: 9,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: getProportionScreenWidth(18.0),
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                            ),
                            onChanged: (text) => _phone = text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomAppBar(
              child: Row(
                children: [
                  CustomButton(
                    icon: 'assets/icons/back_icon.svg',
                    color: Colors.black,
                    press: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: getProportionScreenWidth(12.0)),
                  Expanded(
                    child: Text(
                      "Yangi raqam",
                      style: TextStyle(
                        fontSize: getProportionScreenWidth(24.0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: getProportionScreenWidth(12.0)),
                  CustomButton(
                    icon: 'assets/icons/check_icon1.svg',
                    color: const Color(0xFF00A538),
                    press: () {
                      if (_phone != null) {
                        if (_phone!.length == 9) {
                          Variables.newUserPhone = "998" + _phone.toString();
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Iltimos telefon raqamingizni to'liq kiriting!"),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Iltimos telefon raqamingizni to'liq kiriting!"),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
