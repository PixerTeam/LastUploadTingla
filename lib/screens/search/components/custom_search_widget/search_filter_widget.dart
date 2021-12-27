import 'package:flutter/material.dart';
import 'package:tingla/size_config.dart';

import 'raiting_filter_widget.dart';
import 'select_collection_widget.dart';

class SearchFilterWidget extends StatefulWidget {
  const SearchFilterWidget({
    Key? key,
  }) : super(key: key);

  @override
  _SearchFilterWidgetState createState() => _SearchFilterWidgetState();
}

class _SearchFilterWidgetState extends State<SearchFilterWidget> {
  final PageController _pageController = PageController();
  double _containerHeight = 434.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 450),
      width: SizeConfig.screenWidth,
      height: getProportionScreenHeight(_containerHeight),
      padding: EdgeInsets.symmetric(
        vertical: getProportionScreenHeight(16.0),
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
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                RaitingFilterWidget(
                  press: () {
                    if (_containerHeight == 434.0) {
                      setState(() {
                        _containerHeight = 514.0;
                      });

                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.ease,
                      );
                    } else {
                      setState(() {
                        _containerHeight = 434.0;
                      });

                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.ease,
                      );
                    }
                  },
                ),
                SelectCollectionWidget(
                  press: () {
                    if (_containerHeight == 434.0) {
                      setState(() {
                        _containerHeight = 514.0;
                      });

                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.ease,
                      );
                    } else {
                      setState(() {
                        _containerHeight = 434.0;
                      });

                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.ease,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionScreenWidth(24.0),
            ),
            child: SizedBox(
              height: getProportionScreenHeight(60.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF0F0F54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Qo'llash",
                  style: TextStyle(
                    fontSize: getProportionScreenWidth(20.0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
