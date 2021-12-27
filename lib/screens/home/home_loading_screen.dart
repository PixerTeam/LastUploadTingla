import 'package:flutter/material.dart';
import 'package:tingla/size_config.dart';

class HomeLoadingScreen extends StatelessWidget {
  const HomeLoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        bottom: getProportionScreenHeight(100.0),
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const SizedBox(height: 70.0);
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
