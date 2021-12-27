import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/custom_button.dart';

import '../../../widgets/book_image_widget.dart';

class BookLoadingScreen extends StatelessWidget {
  final dynamic data;
  const BookLoadingScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      // Scroll qilib olish uchun
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // AppBar orqasidan surish uchun 136.0 px Sizedbox berildi
            const SizedBox(
              height: 100.0,
            ),
            // Kitob rasmini ochish uchun Container
            BookImageWidget(
              imageUrl: data!.bookPhoto ?? '',
              title: data!.title ?? '',
              author: '',
            ),
            const SizedBox(
              height: 50.0,
            ),
            // Padding orqali alohida surish uchun
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionScreenWidth(24.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // KITOB HAQIDA qismi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // KITOB HAQDIA TEXT
                      Text(
                        "Kitob haqida",
                        style: TextStyle(
                          fontSize: getProportionScreenWidth(20.0),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomButton(
                        press: () {},
                        icon: 'assets/icons/next_icon.svg',
                        size: 22.0,
                      ),
                    ],
                  ),
                  // KITOB HAQIDA qisqacha
                  Text(
                    data!.description!,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: getProportionScreenWidth(16.0),
                      color: Colors.black.withOpacity(.6),
                      height: 1.8,
                    ),
                  ),
                  SizedBox(
                    height: getProportionScreenHeight(40.0),
                  ),
                  // FIKRLAR qismi
                  Container(
                    width: 60.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: const Color(0xFFF7F7F7),
                    ),
                  ),
                  SizedBox(
                    height: getProportionScreenHeight(16.0),
                  ),
                  Container(
                    height: 30.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: const Color(0xFFF7F7F7),
                    ),
                  ),
                  SizedBox(
                    height: getProportionScreenHeight(16.0),
                  ),
                  Container(
                    height: 120.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: const Color(0xFFF7F7F7),
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

  // _showPaymentWidget(context) {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) {
  //       return PaymentWidget(
  //           price: data!.price,
  //           refresh: () async {
  //             widget.refreshFunction();
  //           });
  //     },
  //   );
  // }
}
