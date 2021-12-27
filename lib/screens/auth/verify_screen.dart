import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tingla/api_functions.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:http/http.dart' as http;

import 'sellect_category_screen.dart';

class RegistorVerifySms extends StatefulWidget {
  // final String verificationId;
  final String phone;
  final String data;

  const RegistorVerifySms({
    Key? key,
    required this.phone,
    required this.data,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegistorVerifySmsState();
  }
}

class RegistorVerifySmsState extends State<RegistorVerifySms> {
  String? password;
  final GlobalKey _formKey = GlobalKey<FormState>();

  TextEditingController smscode = TextEditingController();
  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  Future _getValidateCode(code) async {
    String url = "https://tingla.pixer.uz/users/validate-code";

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "code-validation-id": widget.data,
      },
      body: jsonEncode({"code": code}),
    );

    if (response.statusCode == 201) {
      Variables.userToken = jsonDecode(response.body)['data']['token'];
      Variables.prefs!.setString('token', Variables.userToken!);

      if (Variables.userToken != null) {
        Variables.profileData = await getProfileData();
      }

      return jsonDecode(response.body)['ok'];
    } else {
      throw jsonDecode(response.body)['message'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionScreenWidth(24.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 90.0),
                  Column(
                    children: [
                      buildDuration(),
                      SizedBox(height: getProportionScreenHeight(8.0)),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.phone,
                              style: const TextStyle(
                                fontFamily: "Questrial Regular",
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: " raqamiga SMS-kod yuborildi",
                              style: TextStyle(
                                fontFamily: "Questrial Regular",
                                color: kTextColor.withOpacity(.6),
                              ),
                            ),
                          ],
                        ),
                        // mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      SizedBox(
                        height: getProportionScreenHeight(68.0),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: _formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              length: 5,
                              obscureText: true,
                              // obscuringCharacter: '',
                              blinkWhenObscuring: true,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                inactiveColor: Colors.black,
                                activeColor: Colors.black,
                                selectedColor: Colors.black,
                                shape: PinCodeFieldShape.underline,
                                fieldHeight: 40,
                                fieldWidth: getProportionScreenWidth(60.0),
                                activeFillColor: Colors.black,
                              ),
                              textStyle: TextStyle(
                                  fontSize: getProportionScreenWidth(18.0),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              obscuringWidget: Text(
                                "⚫",
                                style: TextStyle(
                                  fontSize: getProportionScreenWidth(12.0),
                                  color: Colors.black,
                                ),
                              ),
                              cursorColor: Colors.black,
                              animationDuration:
                                  const Duration(milliseconds: 50),
                              errorAnimationController: errorController,
                              controller: smscode,
                              keyboardType: TextInputType.number,
                              onCompleted: (v) {},
                              beforeTextPaste: (text) {
                                return true;
                              },
                              onChanged: (String value) {},
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Qayta yuborish",
                              style: TextStyle(
                                color: const Color(0xFF3243DC),
                                fontSize: getProportionScreenHeight(16.0),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    height: getProportionScreenHeight(60.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        primary: const Color.fromRGBO(15, 15, 84, 1),
                      ),
                      onPressed: () async {
                        await _phoneVerify(context);
                      },
                      child: Text(
                        "Ro`yxatdan o`tish",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: getProportionScreenWidth(20.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionScreenHeight(40.0)),
                ],
              ),
            ),
            CustomAppBar(
              child: Text(
                "Ro’yxatdan o’tish",
                style: TextStyle(
                  color: kTextColor,
                  fontSize: getProportionScreenWidth(28.0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _phoneVerify(BuildContext context) async {
    String? hasError;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return FutureBuilder(
          future: _getValidateCode(smscode.value.text),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              if (snapshot.error ==
                  "Error: Your validation code is incorrect!") {
                hasError =
                    "Ilitmos SMS kodni tekshirib qaytadan urinib ko'ring!";
              } else if (snapshot.error is SocketException) {
                hasError = "Ilitmos internetga ulanib qayta urinib ko'ring!";
              } else {
                hasError = snapshot.error.toString();
              }

              Navigator.pop(context);
            }

            if (snapshot.hasData) {
              if (snapshot.data) {
                Navigator.pop(context);
              }
            }

            return Center(
              child: Container(
                width: getProportionScreenWidth(90.0),
                height: getProportionScreenWidth(90.0),
                padding: EdgeInsets.all(getProportionScreenWidth(24.0)),
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
    );

    if (hasError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            hasError.toString(),
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EndScreen()),
      );
    }
  }

  Widget buildDuration() {
    return CustomTimer(
      from: const Duration(minutes: 2),
      to: const Duration(seconds: 0),
      onBuildAction: CustomTimerAction.auto_start,
      builder: (CustomTimerRemainingTime remaining) {
        return Text(
          "${remaining.minutes}:${remaining.seconds}",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionScreenWidth(50.0),
            fontWeight: FontWeight.w500,
          ),
        );
      },
    );
  }
}
