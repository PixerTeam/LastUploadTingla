import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/screens/details/connection_error_screen.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';
import 'package:tingla/view_model/subcriptions_view_model.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:tingla/widgets/loading_widget.dart';

import 'components/history_card_item.dart';

class PayHistoryScreen extends StatelessWidget {
  const PayHistoryScreen({Key? key}) : super(key: key);
  final bool tolov = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ChangeNotifierProvider(
                create: (context) => SubcriptionViewModel(),
                builder: (context, snapshot) {
                  ApiResponse apiResponse =
                      Provider.of<SubcriptionViewModel>(context).response;

                  switch (apiResponse.status) {
                    case Status.ERROR:

                      return ConnectionErrorScreen(
                        press: () {
                          Provider.of<SubcriptionViewModel>(context,
                                  listen: false)
                              .getSubcriptions();
                        },
                      );

                    case Status.INITIAL:
                      Future(() => Provider.of<SubcriptionViewModel>(context,
                              listen: false)
                          .getSubcriptions());
                      return const LoadingWidget();

                    case Status.LOADING:
                      return const LoadingWidget();

                    case Status.COMPLETED:
                      if (apiResponse.data.isNotEmpty) {
                        return ListView.builder(
                          itemCount: apiResponse.data.length,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(top: 70.0),
                          itemBuilder: (context, index) => Carditem(
                            subcription: apiResponse.data[index],
                          ),
                        );
                      } else {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: getProportionScreenWidth(178.0),
                                height: getProportionScreenWidth(162.0),
                                child: SvgPicture.asset(
                                    "assets/icons/card_history_image_icon.svg"),
                              ),
                              SizedBox(height: getProportionScreenHeight(40.0)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "To'lovlar tarixi yo'q. Kitoblarni ",
                                    style: TextStyle(
                                      fontSize: getProportionScreenWidth(16.0),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Navigator.pop(context);

                                      Variables
                                          .currentScreenIndexNotifier.value = 0;

                                      // HomeScreen.callback();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              getProportionScreenHeight(4.0)),
                                      child: Text(
                                        "ko'rish.",
                                        style: TextStyle(
                                          fontSize:
                                              getProportionScreenWidth(16.0),
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF3243DC),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                  }
                }),
            CustomAppBar(
              child: Row(
                children: [
                  CustomButton(
                    icon: 'assets/icons/back_icon.svg',
                    color: Colors.black,
                    press: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: getProportionScreenWidth(12.0)),
                  Expanded(
                    child: Text(
                      "To'lovlar tarixi",
                      style: TextStyle(
                        fontSize: getProportionScreenWidth(24.0),
                        fontWeight: FontWeight.w500,
                      ),
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
}
