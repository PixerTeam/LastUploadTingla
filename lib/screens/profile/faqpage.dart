import 'package:flutter/material.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/custom_button.dart';

import 'components/custom_extansion_tile.dart';

class FAQpage extends StatefulWidget {
  const FAQpage({Key? key}) : super(key: key);

  @override
  _FAQpageState createState() => _FAQpageState();
}

class _FAQpageState extends State<FAQpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Theme(
          data: ThemeData(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  left: getProportionScreenWidth(24.0),
                  right: getProportionScreenWidth(24.0),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60.0,
                    ),
                    const CustomExpansionTile(
                      text:
                          "Bu loyiha O’zbekistondagi katta loyihalardan biridir va katta maqsadlar qo’yilgan.",
                      title: 'Tingla.uz’ning maqsadi nima?',
                    ),
                    Divider(
                      color: Colors.grey.shade600,
                    ),
                    const CustomExpansionTile(
                      text:
                          "Bu loyiha O’zbekistondagi katta loyihalardan biridir va katta maqsadlar qo’yilgan.",
                      title: 'Nega audiolar pulli?',
                    ),
                    Divider(
                      color: Colors.grey.shade600,
                    ),
                    const CustomExpansionTile(
                      text:
                          "Bu loyiha O’zbekistondagi katta loyihalardan biridir va katta maqsadlar qo’yilgan.",
                      title: 'Bu loyiha O’zbekistondagi 1-loyihami?',
                    ),
                    Divider(
                      color: Colors.grey.shade600,
                    ),
                    const CustomExpansionTile(
                      text:
                          "Bu loyiha O’zbekistondagi katta loyihalardan biridir va katta maqsadlar qo’yilgan.",
                      title: 'Nega audiolar pulli?',
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
                        "FAQ",
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
      ),
    );
  }
}
