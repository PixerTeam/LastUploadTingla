import 'package:flutter/material.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/category_widget.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/custom_button.dart';

class StatusInfoScreen extends StatelessWidget {
  final title;
  const StatusInfoScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getProportionScreenHeight(136.0),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: getProportionScreenWidth(24.0), right: getProportionScreenWidth(24.0), top: getProportionScreenHeight(24.0),
                  ),
                  child: Text(
                    "Oʻtkir Hoshimov 1941-yil, 5-avgustda Toshkent shahrida oddiy bir oilada dunyoga keldi. Yozuvchining bolaligi urush va urushdan keyingi mashaqqatli davrga toʻgʻri keldi. „Oʻsha davrda non tanqis boʻlgani bilan kutubxonalarda kitob koʻp edi“¸ deya eslagan edi yozuvchi oʻz xotiralarida.\nKitob oʻqish barobarida Oʻtkir Hoshimov pochtada xat tarqatuvchi boʻlib ishladi. Aynan mana shu ish Oʻtkir Hoshimovni oddiy odamlarning kitobdagi hayotdan butunlay boshqa turmushiga oshno qildi.\nBoʻlajak yozuvchi 1964-yilda Oʻzbekiston Milliy universitetining (sobiq ToshDU) filologiya fakulteti jurnalistika boʻlimini sirtdan tugatdi.\n1959–1962-yillari „Qizil Oʻzbekiston“, 1963–1966-yil „Toshkent haqiqati“ 1966–1982-yillari „Toshkent oqshomi“ gazetalarida adabiy xodim boʻlib ishladi.",
                    style: TextStyle(
                        fontSize: getProportionScreenWidth(16.0),
                        color: Colors.black.withOpacity(.6),
                        height: getProportionScreenHeight(2.8)),
                  ),
                ),
                SizedBox(
                  height: getProportionScreenHeight(6.0),
                ),
                CollectionWidget(title: "Muallifning asarlari"),
              ],
            ),
          ),
          CustomAppBar(
            child: Row(
              children: [
                CustomButton(
                  press: () {
                    Navigator.pop(context);
                  },
                  icon: 'assets/icons/back_icon.png',
                ),
                SizedBox(width: getProportionScreenWidth(12.0)),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: getProportionScreenWidth(28.0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: getProportionScreenWidth(12.0)),
                CustomButton(
                  press: () {
                    Navigator.pop(context);
                  },
                  icon: 'assets/icons/search_icon.png',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
