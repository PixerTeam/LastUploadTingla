import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/screens/profile/components/profile_button.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/custom_button.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                  left: getProportionScreenWidth(24.0),
                  right: getProportionScreenWidth(24.0),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60.0,
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {},
                      child: SizedBox(
                        height: getProportionScreenHeight(72.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: getProportionScreenWidth(24.0),
                              height: getProportionScreenWidth(24.0),
                              child: SvgPicture.asset(
                                'assets/icons/phone_icon.svg',
                              ),
                            ),
                            SizedBox(width: getProportionScreenWidth(16.0)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Telefon raqam",
                                    style: TextStyle(
                                      fontSize: getProportionScreenWidth(14.0),
                                      color: kTextColor.withOpacity(.5),
                                    ),
                                  ),
                                  SizedBox(
                                      height: getProportionScreenHeight(4.0)),
                                  Text(
                                    "+998 97 422-02-98",
                                    style: TextStyle(
                                      fontSize: getProportionScreenWidth(18.0),
                                      color: kTextColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: getProportionScreenWidth(18.0),
                              height: getProportionScreenWidth(18.0),
                              child: SvgPicture.asset(
                                'assets/icons/cupertino_next_icon.svg',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade600,
                    ),
                    CustomSwitchWidget(
                      title: "Reytingni belgilash",
                      leading: 'assets/icons/star_border_icon.svg',
                      press: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Hali bog\'lanmagan!'),
                          ),
                        );
                      },
                    ),
                    Divider(
                      color: Colors.grey.shade600,
                    ),
                    CustomSwitchWidget(
                      title: "Mutaxassis bilan bog’lanish",
                      leading: 'assets/icons/connect_icon.svg',
                      press: () {},
                    ),
                  ],
                ),
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
                      "Bog’lanish",
                      style: TextStyle(
                        fontSize: getProportionScreenWidth(24.0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
