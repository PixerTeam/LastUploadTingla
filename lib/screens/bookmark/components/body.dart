import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/size_config.dart';

import 'download_screen.dart';
import 'read_book_screen.dart';
import 'saved_screen.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  List icon = [
    Icons.headphones_outlined,
    CupertinoIcons.book,
  ];

  int tanlov1 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const SizedBox(height: 70.0),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionScreenWidth(32.0),
                  vertical: getProportionScreenHeight(24.0)),
              height: getProportionScreenHeight(80.0),
              width: SizeConfig.screenWidth,
              child: Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: TabBar(
                  labelColor: const Color(0xFF0F0F54),
                  indicatorColor: const Color(0xFF0F0F54),
                  unselectedLabelColor: kTextColor.withOpacity(.5),
                  labelStyle: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: getProportionScreenWidth(17.0),
                    fontWeight: FontWeight.w500,
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: EdgeInsets.zero,
                  tabs: const <Tab>[
                    Tab(
                      text: "O'qilayotganlar",
                    ),
                    Tab(
                      text: "Saqlanganlar",
                    ),
                    Tab(
                      text: "Yuklanganlar",
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  Read(),
                  SavedWidget(),
                  Download(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget read(context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(left: getProportionScreenWidth(15.0)),
      child: Column(
        children: [
          Container(
            height: height / 5,
            margin: EdgeInsets.only(
                top: height / 4, bottom: getProportionScreenHeight(30.0)),
            child: Image.asset("assets/images/page1.png"),
          ),
          Text(
            "O'qilayotgan kitoblar yo'q.",
            style: TextStyle(
                fontSize: getProportionScreenWidth(20.0),
                fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                "Ammo kitoblarni",
                style: TextStyle(
                    fontSize: getProportionScreenWidth(16.0),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                " o' qishingiz va tinglashingiz",
                style: TextStyle(
                    fontSize: getProportionScreenWidth(16.0),
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
              Text(
                " mumkin",
                style: TextStyle(
                    fontSize: getProportionScreenWidth(16.0),
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget sing(context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(left: getProportionScreenWidth(15.0)),
      child: Column(
        children: [
          Container(
            height: height / 5,
            margin: EdgeInsets.only(top: height / 4, bottom: 30),
            child: Image.asset("assets/images/page3.png"),
          ),
          Text(
            "Yuklangan kitoblar yo’q.",
            style: TextStyle(
                fontSize: getProportionScreenWidth(20.0),
                fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(left: getProportionScreenWidth(36.0)),
            child: Row(
              children: [
                Text(
                  "Ammo kitoblarni",
                  style: TextStyle(
                      fontSize: getProportionScreenWidth(16.0),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  " yuklab olishingiz",
                  style: TextStyle(
                      fontSize: getProportionScreenWidth(16.0),
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                ),
                Text(
                  " mumkin",
                  style: TextStyle(
                      fontSize: getProportionScreenWidth(16.0),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
