import 'package:flutter/material.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';

// ignore: must_be_immutable
class ChangeNameWidget extends StatelessWidget {
  String? _name;
  ChangeNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          const Spacer(),
          Container(
            decoration:const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionScreenWidth(24.0),
                    vertical: getProportionScreenHeight(24.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Ismingizni kiriting",
                        style: TextStyle(
                          fontSize: getProportionScreenWidth(18.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: getProportionScreenHeight(12.0),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              maxLength: 30,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: Variables.profileData!.name,
                                hintStyle: TextStyle(
                                  color: const Color(0xFF9E9F9F),
                                  fontSize: getProportionScreenWidth(18.0),
                                ),
                                counterText: "",
                              ),
                              onChanged: (text) => _name = text,
                            ),
                          ),
                          Text(
                            "30",
                            style: TextStyle(
                              color: const Color(0xFF9E9F9F),
                              fontSize: getProportionScreenWidth(18.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.8,
                  color: Colors.grey.shade400,
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionScreenWidth(24.0),
                          vertical: getProportionScreenHeight(20.0),
                        ),
                        child: Text(
                          "Bekor qilish",
                          style: TextStyle(
                            fontSize: getProportionScreenWidth(18.0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (_name != null) {
                          if (_name!.length > 2) {
                            Variables.newUserName = _name;
                            Navigator.pop(context);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Iltimos ismingizni to'liq kiriting!"),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionScreenWidth(24.0),
                          vertical: getProportionScreenHeight(20.0),
                        ),
                        child: Text(
                          "Saqlash",
                          style: TextStyle(
                              fontSize: getProportionScreenWidth(18.0),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF00A538)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
