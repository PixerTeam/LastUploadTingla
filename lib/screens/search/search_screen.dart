import 'package:flutter/material.dart';
import 'package:tingla/widgets/custom_app_bar.dart';

import 'components/body.dart';
import 'components/custom_search_widget/custom_search_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: const [
          Body(),
          CustomAppBar(
            height: 80.0,
            child: CustomSearchWidget(),
          ),
        ],
      ),
    );
  }
}
