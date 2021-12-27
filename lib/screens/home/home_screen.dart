import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/screens/auth/check_phone_screen.dart';
import 'package:tingla/screens/details/connection_error_screen.dart';
import 'package:tingla/screens/notification/notification_screen.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';
import 'package:tingla/view_model/home_view_model.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/notification_button.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';
import 'home_loading_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildBody(context, ApiResponse apiResponse) {
    switch (apiResponse.status) {
      case Status.LOADING:
        return const HomeLoadingScreen();
      case Status.COMPLETED:
        return RefreshIndicator(
          displacement: 100,
          onRefresh: () async {
            Variables.opennedCatigories.clear();
            Provider.of<HomeViewModel>(context, listen: false).getCategories();
          },
          color: Colors.black,
          child: const Body(),
        );
      case Status.ERROR:
        if (apiResponse.message == "Unauthorised Request: Token is failed!") {
          Variables.prefs!.remove('token').then((value) {
            Variables.userToken = null;
            Variables.profileData = null;
            Variables.databaseHelper!.deleteAllDatabase().then((value) {
              Variables.currentScreenIndexNotifier.value = 0;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const CheckPhoneNumberScreen(),
                ),
                (Route<dynamic> route) => false,
              );
            });
          });
        }

        return ConnectionErrorScreen(
          press: () async {
            Provider.of<HomeViewModel>(context, listen: false).getCategories();
          },
        );
      case Status.INITIAL:
        Future(() =>
            Provider.of<HomeViewModel>(context, listen: false).getCategories());
        return const HomeLoadingScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ApiResponse apiResponse = Provider.of<HomeViewModel>(context).response;
    return Stack(
      children: [
        _buildBody(context, apiResponse),
        CustomAppBar(
          child: Row(
            children: [
              SizedBox(
                width: getProportionScreenWidth(8.0),
              ),
              SizedBox(
                width: getProportionScreenWidth(120.0),
                height: getProportionScreenWidth(36.0),
                child:
                    SvgPicture.asset('assets/icons/emblem_with_text_icon.svg'),
              ),
              const Spacer(),
              NotificationButton(
                notification: 0,
                icon: 'assets/icons/notification_icon.svg',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
