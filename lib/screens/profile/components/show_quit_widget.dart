import 'package:flutter/material.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/database/database_helper.dart';
import 'package:tingla/screens/auth/check_phone_screen.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';

class ShowQuitDialog extends StatelessWidget {
  const ShowQuitDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionScreenWidth(37.0)),
        child: Container(
          padding: EdgeInsets.all(getProportionScreenWidth(30.0)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ilovadan chiqish",
                style: TextStyle(
                  fontSize: getProportionScreenWidth(20.0),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: getProportionScreenHeight(10.0)),
              Text(
                "Agar siz tizimdan chiqib ketsangiz ilovadagi yuklab olgan kitoblaringiz o’chib ketadi.",
                style: TextStyle(
                  fontSize: getProportionScreenWidth(16.0),
                  height: 1.4,
                ),
              ),
              SizedBox(height: getProportionScreenHeight(36.0)),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: getProportionScreenWidth(46.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          primary: Colors.black.withOpacity(.12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Ortga",
                          style: TextStyle(
                            fontSize: getProportionScreenWidth(20.0),
                            fontWeight: FontWeight.w500,
                            color: kTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: getProportionScreenWidth(12.0)),
                  Expanded(
                    child: SizedBox(
                      height: getProportionScreenWidth(46.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          primary: const Color(0xFFFD4C45).withOpacity(.12),
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                        onPressed: () async {
                          Variables.prefs!.remove('token').then((value) {
                            Variables.userToken = null;
                            Variables.profileData = null;
                            Variables.databaseHelper!
                                .deleteAllDatabase()
                                .then((value) {
                              Variables.currentScreenIndexNotifier.value = 0;
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CheckPhoneNumberScreen(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            });
                          });
                        },
                        child: Text(
                          "Chiqish",
                          style: TextStyle(
                            fontSize: getProportionScreenWidth(20.0),
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFD4C45),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
