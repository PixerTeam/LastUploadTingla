import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tingla/schema/one_category_schema.dart';
import 'package:tingla/widgets/category_item_widget.dart';
import 'package:tingla/size_config.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required OneCategory oneCategory,
  }) : _oneCategory = oneCategory, super(key: key);

  final OneCategory _oneCategory;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        left: getProportionScreenWidth(24.0),
        top: 90.0,
        right: getProportionScreenWidth(8.0),
        bottom: getProportionScreenHeight(24.0),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: getProportionScreenWidth(24.0),
        mainAxisExtent: getProportionScreenHeight(213.0),
      ),
      itemCount: _oneCategory.books!.length,
      itemBuilder: (context, index) {
        return ItemWidget(book: _oneCategory.books![index]);
      },
    );
  }
}