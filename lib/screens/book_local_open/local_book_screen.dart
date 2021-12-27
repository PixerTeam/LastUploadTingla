import 'package:flutter/material.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/custom_button.dart';

import 'components/body.dart';

class LocalBookScreen extends StatelessWidget {
  const LocalBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Body(
              book: Variables.localBook!,
            ),
            CustomAppBar(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomButton(
                    icon: 'assets/icons/back_icon.svg',
                    press: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  CustomButton(
                    icon: 'assets/icons/share_icon.svg',
                    press: () {},
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
