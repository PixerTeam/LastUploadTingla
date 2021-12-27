import 'package:flutter/material.dart';
import 'package:tingla/variables/search_variables.dart';

import 'best_books_widget.dart';
import 'history_items_widget.dart';
import 'result_items_widget.dart';
import 'search_result_items_widget.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();

    SearchVariables.searchController
        .addListener(SearchVariables.searchListener);

    SearchVariables.searchScreenPageController =
        PageController(initialPage: SearchVariables.curentSearchScreen);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: SearchVariables.searchScreenPageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const <Widget>[
        DefaultItemsWidget(),
        HistoryItemWidget(),
        SearchResultWidget(),
        ResultItemsWidget(),
      ],
    );
  }
}
