import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tingla/size_config.dart';

class LoadingCategoryScreen extends StatelessWidget {
  const LoadingCategoryScreen({
    Key? key,
  }) : super(key: key);

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
      itemCount: 9,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(right: getProportionScreenWidth(16.0)),
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
              SizedBox(height: getProportionScreenHeight(8.0)),
              Container(
                width: 80.0,
                height: 16.0,
                color: Colors.grey.withOpacity(.2),
              ),
              SizedBox(height: getProportionScreenHeight(8.0)),
              Container(
                width: 50.0,
                height: 14.0,
                color: Colors.grey.withOpacity(.2),
              ),
            ],
          ),
        );
      },
    );
  }
}
