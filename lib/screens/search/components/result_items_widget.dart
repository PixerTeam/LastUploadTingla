import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/schema/searched_book_schema.dart';
import 'package:tingla/screens/details/connection_error_screen.dart';
import 'package:tingla/widgets/category_item_widget.dart';
import 'package:tingla/screens/category/category_screen.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/search_variables.dart';
import 'package:tingla/widgets/category_widget.dart';

import 'custom_search_widget/search_filter_widget.dart';

class ResultItemsWidget extends StatelessWidget {
  const ResultItemsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: SearchVariables.searchResultNotifier,
      builder: (_, List<SearchedBookSchema> searchedDatas, __) {
        return ValueListenableBuilder(
          valueListenable: SearchVariables.searchStateConnectionNotifier,
          builder: (BuildContext context, SearchStateConnection connection,
              Widget? child) {
            switch (connection) {
              case SearchStateConnection.searching:
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: EdgeInsets.only(
                              left: getProportionScreenWidth(24.0),
                              top: 90.0,
                              right: getProportionScreenWidth(24.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 180.0,
                                  height: 28.0,
                                  color: Colors.grey.withOpacity(.2),
                                ),
                                SizedBox(
                                    height: getProportionScreenHeight(22.0)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(
                        left: getProportionScreenWidth(24.0),
                        right: getProportionScreenWidth(8.0),
                      ),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: getProportionScreenWidth(24.0),
                          mainAxisExtent: getProportionScreenHeight(213.0),
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
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
                          childCount: 9,
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SizedBox(height: getProportionScreenHeight(24.0)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionScreenWidth(24.0)),
                            child: Row(
                              children: [
                                Container(
                                  width: 120.0,
                                  height: 28.0,
                                  color: Colors.grey.withOpacity(.2),
                                ),
                                const Spacer(),
                                Container(
                                  width: 80.0,
                                  height: 28.0,
                                  color: Colors.grey.withOpacity(.2),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: getProportionScreenHeight(20.0)),
                          SizedBox(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(.2),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionScreenHeight(8.0)),
                                      Container(
                                        width: 80.0,
                                        height: 16.0,
                                        color: Colors.grey.withOpacity(.2),
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionScreenHeight(8.0)),
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
                          ),
                          SizedBox(height: getProportionScreenHeight(105.0)),
                        ],
                      ),
                    ),
                  ],
                );

              case SearchStateConnection.completed:
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: EdgeInsets.only(
                              left: getProportionScreenWidth(24.0),
                              top: 80.0,
                              right: getProportionScreenWidth(24.0),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      searchedDatas.isNotEmpty
                                          ? "${searchedDatas.length} ta natija topildi"
                                          : "Natija topilmadi",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionScreenWidth(18.0),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    if (searchedDatas.isNotEmpty)
                                      Container(
                                        width: getProportionScreenWidth(49.0),
                                        height: getProportionScreenWidth(49.0),
                                        padding: EdgeInsets.all(
                                            getProportionScreenWidth(4.0)),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0.0,
                                            primary: const Color(0xFFF5F5F5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            padding: EdgeInsets.all(
                                                getProportionScreenWidth(10.0)),
                                          ),
                                          onPressed: () => _showFilter(context),
                                          child: SvgPicture.asset(
                                            'assets/icons/filter_icon.svg',
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(
                                    height: getProportionScreenHeight(22.0)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(
                        left: getProportionScreenWidth(24.0),
                        right: getProportionScreenWidth(8.0),
                      ),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: getProportionScreenWidth(24.0),
                          mainAxisExtent: getProportionScreenHeight(213.0),
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ItemWidget(book: searchedDatas[index]);
                          },
                          childCount: searchedDatas.length,
                        ),
                      ),
                    ),
                    if (searchedDatas.isNotEmpty)
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            CollectionWidget(
                              id: searchedDatas[0].categoryId,
                              title: "O'xshash kitoblar",
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OpenCollectionScreen(
                                      title: searchedDatas[0].title,
                                      id: searchedDatas[0].categoryId,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: getProportionScreenHeight(105.0)),
                          ],
                        ),
                      ),
                  ],
                );
              
              case SearchStateConnection.hasError:
                return ConnectionErrorScreen(
                  press: () {
                    SearchVariables.onHistory(SearchVariables.result);
                  },
                );
            }
          },
        );
      },
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
