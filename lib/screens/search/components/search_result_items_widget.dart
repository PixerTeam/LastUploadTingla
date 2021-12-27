import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/variables/search_variables.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/schema/searched_book_schema.dart';

// ignore: must_be_immutable
class SearchResultWidget extends StatefulWidget {
  const SearchResultWidget({Key? key}) : super(key: key);

  @override
  State<SearchResultWidget> createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<SearchedBookSchema>>(
      valueListenable: SearchVariables.searchResultNotifier,
      builder: (_, List<SearchedBookSchema> searchedDatas, __) {
        return ValueListenableBuilder(
          valueListenable: SearchVariables.searchStateConnectionNotifier,
          builder: (BuildContext context, SearchStateConnection connection,
              Widget? child) {
            switch (connection) {
              case SearchStateConnection.searching:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );

              case SearchStateConnection.completed:
                if (searchedDatas.isNotEmpty) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      left: getProportionScreenWidth(24.0),
                      right: getProportionScreenWidth(24.0),
                      top: 80.0,
                    ),
                    itemCount: searchedDatas.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          SearchVariables.onSelected(searchedDatas[index]);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: getProportionScreenHeight(16.0)),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/search_icon.svg',
                                width: getProportionScreenWidth(22.0),
                                height: getProportionScreenWidth(22.0),
                              ),
                              SizedBox(width: getProportionScreenWidth(12.0)),
                              Expanded(
                                child: Row(
                                  children: [
                                    ValueListenableBuilder<List<String>>(
                                      valueListenable:
                                          SearchVariables.blackTextListNotifier,
                                      builder:
                                          (context, searchedDatas, notifier) {
                                        return Text(
                                          searchedDatas[index],
                                          style: TextStyle(
                                            fontSize:
                                                getProportionScreenWidth(18.0),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        );
                                      },
                                    ),
                                    ValueListenableBuilder<List<String>>(
                                      valueListenable:
                                          SearchVariables.greyTextListNotifier,
                                      builder:
                                          (context, searchedDatas, notifier) {
                                        return Text(
                                          searchedDatas[index],
                                          style: TextStyle(
                                            fontSize:
                                                getProportionScreenWidth(18.0),
                                            fontWeight: FontWeight.w400,
                                            color: kTextColor.withOpacity(.3),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: getProportionScreenWidth(12.0)),
                              SvgPicture.asset(
                                'assets/icons/arrow_up_icon.svg',
                                width: getProportionScreenWidth(16.0),
                                height: getProportionScreenWidth(16.0),
                                color: Colors.black.withOpacity(.5),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(top: 104.0),
                    child: Text(
                      'Bunday kitob mavjud emas',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              case SearchStateConnection.hasError:
                return const Padding(
                  padding: EdgeInsets.only(top: 104.0),
                  child: Text(
                    "Internet topilmadi!\nInternetni tekshirib qaytadan urinib ko'ring",
                    textAlign: TextAlign.center,
                  ),
                );
            }
          },
        );
      },
    );
  }
}
