import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/size_config.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:tingla/variables/variables.dart';

import '../connect_as_screen.dart';
import '../edit_screen.dart';
import '../faqpage.dart';
import '../maxfiylikpage.dart';
import '../pay_history_screen.dart';
import 'profile_button.dart';
import 'show_quit_widget.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Widget _image = Container(
      height: getProportionScreenWidth(70.0),
      width: getProportionScreenWidth(70.0),
      padding: EdgeInsets.all(getProportionScreenWidth(16.0)),
      decoration: const BoxDecoration(
        color: Color(0xFFE5E5E5),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        'assets/icons/person_icon.svg',
        color: Colors.black.withOpacity(.6),
      ),
    );

    if (Variables.profileData!.userPhoto != null) {
      _image = CachedNetworkImage(
        imageUrl: Variables.profileData!.userPhoto ?? '',
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
          height: getProportionScreenWidth(70.0),
          width: getProportionScreenWidth(70.0),
        ),
        errorWidget: (context, error, imageProvider) => Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          height: getProportionScreenWidth(70.0),
          width: getProportionScreenWidth(70.0),
        ),
        placeholder: (context, imageProvider) => Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          height: getProportionScreenWidth(70.0),
          width: getProportionScreenWidth(70.0),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        left: getProportionScreenWidth(24.0),
        right: getProportionScreenWidth(24.0),
        top: getProportionScreenHeight(24.0),
        bottom: getProportionScreenHeight(100.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: _image,
                trailing: GestureDetector(
                  child: Container(
                    height: getProportionScreenWidth(44.0),
                    width: getProportionScreenWidth(44.0),
                    padding: EdgeInsets.all(getProportionScreenWidth(12.0)),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/pencil_icon.svg',
                      color: Colors.black,
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => const EditPage(),
                      ),
                    )
                        .then((value) {
                      Variables.newUserName = null;
                      Variables.newUserPhone = null;
                      Variables.newUserPhoto = null;

                      setState(() {});
                      Variables.bottomNavigationState();
                    });
                  },
                ),
                title: Text(
                  Variables.profileData!.name!,
                  style: TextStyle(
                    fontSize: getProportionScreenWidth(20.0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "+${Variables.profileData!.phone!.substring(0, 3)} ${Variables.profileData!.phone!.substring(3, 5)} ${Variables.profileData!.phone!.substring(5, 8)}-${Variables.profileData!.phone!.substring(8, 10)}-${Variables.profileData!.phone!.substring(10, 12)}",
                  style: TextStyle(
                    fontSize: getProportionScreenWidth(16.0),
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(50, 67, 220, 1),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionScreenHeight(26.0),
              ),
              CustomSwitchWidget(
                title: "Bildirishnomalar",
                subtitle: "Ba’zi yangiliklar va xabarlar uchun",
                leading: 'assets/icons/notification_icon.svg',
                trailing: FlutterSwitch(
                  height: getProportionScreenWidth(24.0),
                  width: getProportionScreenWidth(46.0),
                  padding: 0.5,
                  borderRadius: 12.0,
                  toggleSize: getProportionScreenWidth(22.0),
                  inactiveColor: const Color(0xFF000000).withOpacity(.1),
                  activeColor: const Color(0xFF3243DC),
                  value: Variables.notification,
                  onToggle: (value) {
                    Variables.notification = value;

                    setState(() {});
                  },
                ),
              ),
              Divider(
                color: Colors.grey.shade600,
              ),
              CustomSwitchWidget(
                title: "Maxfiylik siyosati",
                leading: 'assets/icons/shield_check_icon.svg',
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Maxfiylik(),
                    ),
                  );
                },
              ),
              Divider(
                color: Colors.grey.shade600,
              ),
              CustomSwitchWidget(
                title: "FAQ",
                leading: 'assets/icons/faq_icon.svg',
                press: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => const FAQpage()))
                      .then((value) {
                    // setState(() {});
                  });
                },
              ),
              Divider(
                color: Colors.grey.shade600,
              ),
              CustomSwitchWidget(
                title: "To'lovlar tarixi",
                leading: 'assets/icons/credit_card_icon.svg',
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PayHistoryScreen(),
                    ),
                  );
                },
              ),
              Divider(
                color: Colors.grey.shade600,
              ),
              CustomSwitchWidget(
                title: "Bog'lanish",
                leading: 'assets/icons/phone_icon.svg',
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ConnectScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          CustomSwitchWidget(
            title: "Chiqish",
            leading: 'assets/icons/quit_icon.svg',
            trailing: const SizedBox(),
            press: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const ShowQuitDialog();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
