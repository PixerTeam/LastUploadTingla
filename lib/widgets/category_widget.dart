import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tingla/bloc/tingla_cubit.dart';
import 'package:tingla/bloc/tingla_state.dart';
import 'package:tingla/schema/one_category_schema.dart';
import 'package:tingla/widgets/category_item_widget.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';

// ignore: must_be_immutable
class CollectionWidget extends StatelessWidget {
  final String title;
  final VoidCallback? press;
  final String? id;
  final TextStyle? textStyle;
  bool isOpenned = false;

  CollectionWidget({
    Key? key,
    required this.title,
    this.press,
    this.id,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isOpenned) {
      for (OneCategory category in Variables.opennedCatigories) {
        if (category.id == id) {
          isOpenned = true;
          break;
        }
      }
    }

    return Padding(
      padding: EdgeInsets.only(top: getProportionScreenWidth(24.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionScreenWidth(24.0)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle ??
                        TextStyle(
                          fontSize: getProportionScreenWidth(24.0),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                SizedBox(width: getProportionScreenWidth(8.0)),
                GestureDetector(
                  onTap: press,
                  child: Row(
                    children: [
                      Text(
                        "Barchasi",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: getProportionScreenWidth(16.0),
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      SvgPicture.asset(
                        'assets/icons/next_icon.svg',
                        width: getProportionScreenWidth(14.0),
                        height: getProportionScreenWidth(14.0),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionScreenHeight(20.0)),
          BlocProvider<TinglaCubit>(
            create: (context) => TinglaCubit(
                !isOpenned ? const TinglaLoading() : const TinglaCompleted()),
            child: Builder(
              builder: (context) {
                if (!isOpenned) {
                  context.read<TinglaCubit>().getOneCategory(id);
                }

                return BlocConsumer<TinglaCubit, TinglaState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    // if (state is TinglaError) {
                    //   print(state.message);
                    // }

                    if (state is TinglaCompleted) {
                      if (!isOpenned) {
                        Variables.opennedCatigories.add(state.response);
                      }  

                      late OneCategory _currentCategory;

                      Variables.opennedCatigories.forEach(
                        (OneCategory category) {
                          if (category.id == id) {
                            _currentCategory = category;
                          }
                        },
                      );

                      return SizedBox(
                        height: getProportionScreenHeight(213.0),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionScreenWidth(24.0),
                          ),
                          itemBuilder: (context, index) => ItemWidget(
                            book: _currentCategory.books![index],
                          ),
                          itemCount: _currentCategory.books!.length,
                        ),
                      );
                    }

                    return SizedBox(
                      height: getProportionScreenHeight(213.0),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionScreenWidth(24.0)),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            width: getProportionScreenWidth(110.0),
                            margin: EdgeInsets.only(
                                right: getProportionScreenWidth(16.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(.2),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: getProportionScreenHeight(8.0)),
                                Container(
                                  width: 80.0,
                                  height: 16.0,
                                  color: Colors.grey.withOpacity(.2),
                                ),
                                SizedBox(
                                    height: getProportionScreenHeight(8.0)),
                                Container(
                                  width: 50.0,
                                  height: 14.0,
                                  color: Colors.grey.withOpacity(.2),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
