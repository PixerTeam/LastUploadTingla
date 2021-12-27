import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tingla/size_config.dart';

class LoadingBestBooks extends StatelessWidget {
  const LoadingBestBooks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: EdgeInsets.only(
                  left: getProportionScreenWidth(24.0),
                  top: getProportionScreenHeight(24.0),
                  right: getProportionScreenWidth(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 70.0),
                    Text(
                      "Ko’p qidirilgan kitoblar",
                      style: TextStyle(
                        fontSize: getProportionScreenWidth(20.0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: getProportionScreenHeight(24.0)),
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
            bottom: getProportionScreenHeight(124.0),
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
                  margin:
                      EdgeInsets.only(right: getProportionScreenWidth(16.0)),
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
              childCount: 9,
            ),
          ),
        ),
      ],
    );
  }
}
