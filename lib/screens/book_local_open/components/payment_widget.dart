import 'package:flutter/material.dart';
import 'package:tingla/api_functions.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';

import 'payment_button.dart';
import 'show_complect_message_widget.dart';

class PaymentWidget extends StatefulWidget {
  final refresh;
  final price;
  const PaymentWidget({
    Key? key,
    required this.price,
    this.refresh,
  }) : super(key: key);

  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  int _activePay = 0;
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
              Text(
                "Sizning buyurtmangiz",
                style: TextStyle(
                  fontSize: getProportionScreenWidth(22.0),
                  fontWeight: FontWeight.bold,
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
                          fontSize: getProportionScreenWidth(16.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        "Chegirma:",
                        style: TextStyle(
                          color: kTextColor.withOpacity(.6),
                          fontSize: getProportionScreenWidth(16.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        "Jami:",
                        style: TextStyle(
                          color: kTextColor.withOpacity(.6),
                          fontSize: getProportionScreenWidth(16.0),
                          fontWeight: FontWeight.bold,
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        "10%",
                        style: TextStyle(
                          fontSize: getProportionScreenWidth(20.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        "22 500 UZS",
                        style: TextStyle(
                          fontSize: getProportionScreenWidth(20.0),
                          fontWeight: FontWeight.bold,
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
                "To’lov turini tanlang",
                style: TextStyle(
                  fontSize: getProportionScreenWidth(20.0),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: getProportionScreenWidth(20.0),
              ),
              Row(
                children: [
                  PaymentButton(
                    active: _activePay,
                    title: "Payme orqali\nto’lang",
                    image: const AssetImage('assets/images/payme_logo.png'),
                    index: 0,
                    press: () {
                      setState(() {
                        _activePay = 0;
                      });
                    },
                  ),
                  SizedBox(
                    width: getProportionScreenWidth(12.0),
                  ),
                  PaymentButton(
                    active: _activePay,
                    title: "Visa orqali\nto’lang",
                    image: const AssetImage('assets/images/visa_logo.png'),
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
                    bool _failed = false;
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return FutureBuilder(
                          future: getBuyBook(Variables.openBook!.data!.id),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              _failed = true;
                            }

                            if (snapshot.hasData) {
                              if (snapshot.data['ok']) {
                                return const ShowDialogWidget();
                              } else {
                                Navigator.pop(context);
                              }
                            }

                            return Center(
                              child: Container(
                                width: getProportionScreenWidth(90.0),
                                height: getProportionScreenWidth(90.0),
                                padding: EdgeInsets.all(
                                    getProportionScreenWidth(24.0)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: const CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ).then((value) {
                      if (!_failed) {
                        Navigator.pop(context);
                      }
                    });

                    if (_failed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Failed Buy Book!"),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "To’lash",
                    style: TextStyle(
                      fontSize: getProportionScreenWidth(19.0),
                      fontWeight: FontWeight.bold,
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
