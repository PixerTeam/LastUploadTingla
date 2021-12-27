import 'package:flutter/material.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/custom_button.dart';

import 'components/status_widget.dart';

class OpenBookInfoScreen extends StatelessWidget {
  final String description;
  final DateTime? createdAt;
  final String headsCount;
  final String categoryTitle;
  const OpenBookInfoScreen({
    Key? key,
    required this.description,
    required this.createdAt,
    required this.headsCount,
    required this.categoryTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String createdAtString = "Ma'lumot mavjud emas!";
    if (createdAt != null) {
      createdAtString =
          '${createdAt!.day < 10 ? "0${createdAt!.day}" : createdAt!.day}.${createdAt!.month < 10 ? "0${createdAt!.month}" : createdAt!.month}.${createdAt!.year}';
    }
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                vertical: getProportionScreenWidth(24.0),
                horizontal: getProportionScreenHeight(24.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60.0,
                  ),
                  // KITOB HAQDIA TEXT
                  Text(
                    "Kitob haqida",
                    style: TextStyle(
                      fontSize: getProportionScreenWidth(24.0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: getProportionScreenHeight(24.0),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: getProportionScreenWidth(16.0),
                      color: Colors.black.withOpacity(.6),
                      height: getProportionScreenHeight(2.8),
                    ),
                  ),
                  SizedBox(
                    height: getProportionScreenHeight(20.0),
                  ),
                  const Divider(
                    height: 0,
                  ),
                  SizedBox(
                    height: getProportionScreenHeight(20.0),
                  ),
                  StatusWidget(
                    icon: 'assets/icons/clock_icon.svg',
                    title: "Joylangan sana",
                    text: createdAtString,
                  ),
                  StatusWidget(
                    icon: 'assets/icons/book_open.svg',
                    title: "Boblar",
                    text: headsCount,
                  ),
                  const StatusWidget(
                    icon: 'assets/icons/flag_icon.svg',
                    title: "Til",
                    text: "O’zbek tili",
                  ),
                  StatusWidget(
                    icon: 'assets/icons/menu_icon.svg',
                    title: "Kategoriya",
                    text: categoryTitle,
                  ),
                ],
              ),
            ),
            CustomAppBar(
              child: CustomButton(
                press: () {
                  Navigator.pop(context);
                },
                icon: 'assets/icons/back_icon.svg',
              ),
            )
          ],
        ),
      ),
    );
  }
}
