import 'package:flutter/material.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/variables/filter_variables.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/custom_button.dart';

class SelectCollectionWidget extends StatefulWidget {
  final press;

  const SelectCollectionWidget({
    Key? key,
    this.press,
  }) : super(key: key);

  @override
  _SelectCollectionWidgetState createState() => _SelectCollectionWidgetState();
}

class _SelectCollectionWidgetState extends State<SelectCollectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionScreenWidth(14.0),
          ),
          child: CustomButton(
            icon: 'assets/icons/back_icon.svg',
            size: 24.0,
            press: widget.press,
          ),
        ),
        SizedBox(height: getProportionScreenHeight(16.0)),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionScreenWidth(24.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kategoriyalar",
                style: TextStyle(
                  fontSize: getProportionScreenWidth(20.0),
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: _clear,
                child: Text(
                  "Tozalash",
                  style: TextStyle(
                    color: Color(0xFF3243DC),
                    fontSize: getProportionScreenWidth(18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: getProportionScreenHeight(10.0)),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionScreenWidth(14.0),
            ),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: getProportionScreenHeight(46.0),
              crossAxisSpacing: getProportionScreenWidth(60.0),
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: Color(0xFF00A538),
                      side: BorderSide(color: kTextColor.withOpacity(.6)),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: FilterVariables.collectionItems[index][1],
                      onChanged: (value) {
                        if (FilterVariables.collectionItems[index][1]) {
                          setState(() {
                            FilterVariables.collectionItems[index][1] =
                                !FilterVariables.collectionItems[index][1];

                            --FilterVariables.collectionItemsLength;
                          });
                        } else {
                          setState(() {
                            FilterVariables.collectionItems[index][1] =
                                !FilterVariables.collectionItems[index][1];

                            ++FilterVariables.collectionItemsLength;
                          });
                        }
                      },
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (FilterVariables.collectionItems[index][1]) {
                            setState(() {
                              FilterVariables.collectionItems[index][1] =
                                  !FilterVariables.collectionItems[index][1];

                              --FilterVariables.collectionItemsLength;
                            });
                          } else {
                            setState(() {
                              FilterVariables.collectionItems[index][1] =
                                  !FilterVariables.collectionItems[index][1];

                              ++FilterVariables.collectionItemsLength;
                            });
                          }
                        },
                        child: Text(
                          FilterVariables.collectionItems[index][0],
                          style: TextStyle(
                            fontSize: getProportionScreenWidth(20.0),
                            color: FilterVariables.collectionItems[index][1]
                                ? kTextColor
                                : kTextColor.withOpacity(.6),
                            fontWeight: FilterVariables.collectionItems[index]
                                    [1]
                                ? FontWeight.w500
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _clear() {
    if (FilterVariables.collectionItemsLength != 0) {
      int index = 0;
      for (List item in FilterVariables.collectionItems) {
        if (item[1]) FilterVariables.collectionItems[index][1] = false;

        index++;
      }
    }

    setState(() {
      FilterVariables.collectionItemsLength = 0;
    });
  }
}
