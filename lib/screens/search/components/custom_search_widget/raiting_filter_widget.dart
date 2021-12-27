import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/variables/filter_variables.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/custom_button.dart';

import 'rating_button.dart';

class RaitingFilterWidget extends StatefulWidget {
  final press;
  const RaitingFilterWidget({
    Key? key,
    this.press,
  }) : super(key: key);

  @override
  _RaitingFilterWidgetState createState() => _RaitingFilterWidgetState();
}

class _RaitingFilterWidgetState extends State<RaitingFilterWidget> {
  String _collectionText = "Tanlanmagan";

  @override
  Widget build(BuildContext context) {
    final List<String> _selectedCollectionTexts = [];
    _collectionText = "";
    if (FilterVariables.collectionItemsLength != 0) {
      for (List item in FilterVariables.collectionItems) {
        if (item[1]) {
          _selectedCollectionTexts.add(item[0]);
        }
      }
    } else {
      _collectionText = "Tanlanmagan";
    }

    if (_selectedCollectionTexts.length != 0) {
      for (int index = 0; index < _selectedCollectionTexts.length; index++) {
        if (index != _selectedCollectionTexts.length - 1) {
          _collectionText += _selectedCollectionTexts[index] + ", ";
        } else {
          _collectionText += _selectedCollectionTexts[index];
        }
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionScreenWidth(24.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reyting",
            style: TextStyle(
              fontSize: getProportionScreenWidth(18.0),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: getProportionScreenHeight(16.0),
          ),
          Row(
            children: [
              RatingFilterButton(
                width: 101.0,
                height: 42.0,
                active: FilterVariables.raitIndex == 0,
                press: () {
                  setState(() {
                    FilterVariables.raitIndex = 0;
                  });
                },
                child: Text(
                  "Istalgan",
                  style: TextStyle(
                    fontSize: getProportionScreenWidth(16.0),
                    color: FilterVariables.raitIndex == 0
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(width: getProportionScreenWidth(12.0)),
              RatingFilterButton(
                width: 76.0,
                height: 42.0,
                active: FilterVariables.raitIndex == 1,
                press: () {
                  setState(() {
                    FilterVariables.raitIndex = 1;
                  });
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/star_fill_icon.svg',
                      width: getProportionScreenWidth(12.0),
                      height: getProportionScreenWidth(12.0),
                      color: FilterVariables.raitIndex == 1
                          ? Colors.white
                          : Color(0xFFFCBD2C),
                    ),
                    SizedBox(
                      width: getProportionScreenWidth(5.0),
                    ),
                    Text(
                      "3.5",
                      style: TextStyle(
                        fontSize: getProportionScreenWidth(16.0),
                        color: FilterVariables.raitIndex == 1
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: getProportionScreenWidth(12.0)),
              RatingFilterButton(
                width: 76.0,
                height: 42.0,
                active: FilterVariables.raitIndex == 2,
                press: () {
                  setState(() {
                    FilterVariables.raitIndex = 2;
                  });
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/star_fill_icon.svg',
                      width: getProportionScreenWidth(12.0),
                      height: getProportionScreenWidth(12.0),
                      color: FilterVariables.raitIndex == 2
                          ? Colors.white
                          : const Color(0xFFFCBD2C),
                    ),
                    SizedBox(
                      width: getProportionScreenWidth(5.0),
                    ),
                    Text(
                      "4.0",
                      style: TextStyle(
                        fontSize: getProportionScreenWidth(16.0),
                        color: FilterVariables.raitIndex == 2
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: getProportionScreenWidth(12.0)),
              RatingFilterButton(
                width: 76.0,
                height: 42.0,
                active: FilterVariables.raitIndex == 3,
                press: () {
                  setState(() {
                    FilterVariables.raitIndex = 3;
                  });
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/star_fill_icon.svg',
                      width: getProportionScreenWidth(12.0),
                      height: getProportionScreenWidth(12.0),
                      color: FilterVariables.raitIndex == 3
                          ? Colors.white
                          : const Color(0xFFFCBD2C),
                    ),
                    SizedBox(
                      width: getProportionScreenWidth(5.0),
                    ),
                    Text(
                      "4.5",
                      style: TextStyle(
                        fontSize: getProportionScreenWidth(16.0),
                        color: FilterVariables.raitIndex == 3
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: getProportionScreenHeight(40.0),
          ),
          Text(
            "Kitob",
            style: TextStyle(
              fontSize: getProportionScreenWidth(18.0),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: getProportionScreenHeight(16.0),
          ),
          Row(
            children: [
              RatingFilterButton(
                width: 73.0,
                active: false,
                child: Text(
                  "Top",
                  style: TextStyle(
                    fontSize: getProportionScreenWidth(16.0),
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(width: getProportionScreenWidth(12.0)),
              RatingFilterButton(
                width: 85.0,
                active: false,
                child: Text(
                  "Yangi",
                  style: TextStyle(
                    fontSize: getProportionScreenWidth(16.0),
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(width: getProportionScreenWidth(12.0)),
              RatingFilterButton(
                width: 114.0,
                active: false,
                child: Text(
                  "Bestseller",
                  style: TextStyle(
                    fontSize: getProportionScreenWidth(16.0),
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: getProportionScreenHeight(40.0),
          ),
          InkWell(
            onTap: widget.press,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kategoriyalar",
                        style: TextStyle(
                          fontSize: getProportionScreenWidth(16.0),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        _collectionText,
                        style: TextStyle(
                          fontSize: getProportionScreenWidth(18.0),
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                CustomButton(
                  icon: 'assets/icons/next_icon.svg',
                  size: 24.0,
                  press: widget.press,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
