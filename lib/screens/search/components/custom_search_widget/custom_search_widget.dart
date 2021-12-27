import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/variables/search_variables.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/custom_button.dart';

import 'search_filter_widget.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0xFFFAFAFA),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionScreenWidth(14.0),
            ),
            child: ValueListenableBuilder(
              valueListenable: SearchVariables.isActiveNotifier,
              builder: (_, bool isActive, __) {
                return SvgPicture.asset(
                  'assets/icons/search_icon.svg',
                  color: isActive ? Colors.black : kTextColor.withOpacity(.3),
                  width: getProportionScreenWidth(24.0),
                  height: getProportionScreenWidth(24.0),
                );
              },
            ),
          ),
          Expanded(
            child: TextField(
              focusNode: SearchVariables.focus,
              controller: SearchVariables.searchController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              cursorColor: Colors.black,
              cursorWidth: 1.0,
              style: TextStyle(
                fontSize: getProportionScreenWidth(20.0),
                color: kTextColor,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Qidirish",
                hintStyle: TextStyle(
                  fontSize: getProportionScreenWidth(20.0),
                  color: kTextColor.withOpacity(.3),
                  fontWeight: FontWeight.w400,
                ),
              ),
              onChanged: SearchVariables.onChanged,
              onSubmitted: SearchVariables.onSubmitted,
              onTap: SearchVariables.onTap,
            ),
          ),
          ValueListenableBuilder(
            valueListenable: SearchVariables.searchTextNotifier,
            builder: (BuildContext context, String text, Widget? child) {
              if (text.isEmpty) {
                return Container(
                  width: getProportionScreenWidth(48.0),
                  height: getProportionScreenWidth(48.0),
                  padding: EdgeInsets.all(getProportionScreenWidth(4.0)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF0F0F54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      padding: EdgeInsets.all(getProportionScreenWidth(10.0)),
                    ),
                    onPressed: () => _showFilter(context),
                    child: SvgPicture.asset(
                      'assets/icons/filter_icon.svg',
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                return CustomButton(
                  icon: 'assets/icons/clear_icon.svg',
                  press: SearchVariables.clearText,
                  color: Colors.black.withOpacity(.4),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _showFilter(context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const SearchFilterWidget(),
    );
  }
}
