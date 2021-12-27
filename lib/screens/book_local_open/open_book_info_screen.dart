import 'package:flutter/material.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/custom_button.dart';

import 'components/status_widget.dart';
import 'status_info_screen.dart';

class OpenBookInfoScreen extends StatelessWidget {
  const OpenBookInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                SizedBox(
                  height: getProportionScreenHeight(136.0),
                ),
                
                // KITOB HAQDIA TEXT
                Text(
                  "Kitob haqida",
                  style: TextStyle(
                    fontSize: getProportionScreenWidth(24.0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: getProportionScreenHeight(24.0),
                ),
                Text(
                  "Odamda masʼuliyat hissi bo‘lmasligi aybni birovga to‘nkash, o‘zini jabrdiyda his etib norozi bo‘lish, oxir-oqibat ishni ortga surishga sabab bo‘ladi. Shaxsiy javobgarliksiz hech bir kompaniya yoki inson erkin  bozorda muvaffaqiyatli raqobatlashishi, o‘z oldiga qo‘ygan maqsad-vazifalariga erishishi, mukammal xizmat ko‘rsatishi, ajoyib jamoaviy ishda qatnashishi va odamlarni professional o‘stirishi ehtimoldan juda yiroq.\n\nJon G. Millerning fikricha, kompaniyalar jabr ko‘rayotgan bu muammolarni kimnidir ayblash orqali hal qilib bo‘lmaydi. Masalaning chinakam yechimi har birimiz shaxsiy javobgarlikni his etganimizdagina topiladi. Miller o‘zining ushbu kitobida “Nima uchun hammasini biz bajarishimiz kerak?” yoki “Aybdor kim o‘zi?” singari salbiy va noto‘g‘ri berilgan savollar odamlarda masʼuliyat yetishmasligidan darak beradi, deydi. “Vaziyatni yaxshilash uchun nima qila olaman?” yoki “Men kanday hissa qo‘shishim mumkin?” kabi to‘g‘ri savollar esa hayotimiz va jamoamizni ham o‘zgartirib yuboradi.",
                  style: TextStyle(
                    fontSize: getProportionScreenWidth(16.0),
                    color: Colors.black.withOpacity(.6),
                    height: getProportionScreenHeight(2.8),
                  ),
                ),
                SizedBox(
                  height: getProportionScreenHeight(43.0),
                ),
                StatusWidget(
                  icon: 'assets/icons/pencil_icon.png',
                  title: "Muallif",
                  text: "Antuan de Sent Ekzyuperi",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StatusInfoScreen(
                          title: "Antuan de Sent Ekzyuperi",
                        ),
                      ),
                    );
                  },
                ),
                const StatusWidget(
                  icon: 'assets/icons/mickrophone_icon.svg',
                  title: "Suxandon",
                  text: "Akmal Fayziyev",
                ),
                const StatusWidget(
                  icon: 'assets/icons/clock_icon.svg',
                  title: "Joylangan sana",
                  text: "24.04.2021",
                ),
                const StatusWidget(
                  icon: 'assets/icons/book_open.svg',
                  title: "Betlar",
                  text: "257",
                ),
                const StatusWidget(
                  icon: 'assets/icons/flag_icon.svg',
                  title: "Til",
                  text: "O’zbek tili",
                ),
                const StatusWidget(
                  icon: 'assets/icons/menu_icon.svg',
                  title: "Kategoriya",
                  text: "Badiiy, tarixiy",
                ),
              ],
            ),
          ),
          CustomAppBar(
            child: CustomButton(
              press: () {
                Navigator.pop(context);
              },
              icon: 'assets/icons/back_icon.png',
            ),
          )
        ],
      ),
    );
  }
}
