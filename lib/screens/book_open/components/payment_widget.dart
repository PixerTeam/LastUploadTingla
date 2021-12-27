import 'package:flutter/material.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/screens/details/oson_webview_screen.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/view_model/network_book_view_model.dart';
import 'package:provider/provider.dart';

import 'payment_button.dart';

class PaymentWidget extends StatefulWidget {
  final String price;
  final String id;
  const PaymentWidget({
    Key? key,
    required this.price,
    required this.id,
  }) : super(key: key);

  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  int _activePay = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.symmetric(
            vertical: getProportionScreenHeight(16.0),
            horizontal: getProportionScreenWidth(24.0),
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: SizedBox(
                  width: getProportionScreenWidth(60.0),
                  child: const Divider(
                    height: 0,
                    thickness: 2.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                "Sizning buyurtmangiz",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: getProportionScreenHeight(25.0),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Audiokitob narxi:",
                        style: TextStyle(
                          color: kTextColor.withOpacity(.6),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        "Chegirma:",
                        style: TextStyle(
                          color: kTextColor.withOpacity(.6),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        "Jami:",
                        style: TextStyle(
                          color: kTextColor.withOpacity(.6),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: getProportionScreenWidth(36.0),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 1.0),
                      Text(
                        "${widget.price} UZS",
                        style: TextStyle(
                          fontSize: getProportionScreenWidth(20.0),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: getProportionScreenHeight(6.0)),
                      Text(
                        "0%",
                        style: TextStyle(
                          fontSize: getProportionScreenWidth(20.0),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: getProportionScreenHeight(6.0)),
                      Text(
                        "${widget.price} UZS",
                        style: TextStyle(
                          fontSize: getProportionScreenWidth(20.0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: getProportionScreenHeight(25.0),
              ),
              Text(
                "To'lov turini tanlang",
                style: TextStyle(
                  fontSize: getProportionScreenWidth(20.0),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: getProportionScreenWidth(20.0),
              ),
              Row(
                children: [
                  PaymentButton(
                    active: _activePay,
                    title: "Oson orqali to'lang",
                    image: const AssetImage('assets/images/oson_logo.png'),
                    index: 1,
                    press: () {
                      setState(() {
                        _activePay = 1;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: getProportionScreenHeight(50.0),
              ),
              SizedBox(
                height: getProportionScreenHeight(60.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF0F0F54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () async {
                    if (_activePay == 1) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return OsonWebviewScreen(
                            id: widget.id,
                          );
                        },
                      ).then((value) {
                        Navigator.pop(context);
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "To'lash",
                    style: TextStyle(
                      fontSize: getProportionScreenWidth(20.0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
