import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/widgets/category_item_widget.dart';
import 'package:tingla/size_config.dart';
import 'package:provider/provider.dart';
import 'package:tingla/view_model/author_book_category_view_model.dart';

// ignore: must_be_immutable
class AuthorBookWidget extends StatelessWidget {
  final String title;
  final String authorName;
  final VoidCallback? press;
  final String authorId;
  final TextStyle? textStyle;
  bool isOpenned = false;

  AuthorBookWidget({
    Key? key,
    required this.title,
    this.press,
    required this.authorId,
    this.textStyle,
    required this.authorName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          ChangeNotifierProvider(
            create: (context) => AuthorBookCategoryViewModel(),
            builder: (context, value) {
              ApiResponse apiResponse =
                  Provider.of<AuthorBookCategoryViewModel>(context).response;

              switch (apiResponse.status) {
                case Status.INITIAL:
                  Future(() => Provider.of<AuthorBookCategoryViewModel>(context,
                          listen: false)
                      .getAuthorBookCategory(authorId: authorId));

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
                  );
                case Status.LOADING:
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
                  );

                case Status.COMPLETED:
                  return SizedBox(
                    height: getProportionScreenHeight(213.0),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionScreenWidth(24.0),
                      ),
                      itemBuilder: (context, index) => ItemWidget(
                        book: apiResponse.data[index],
                        authorName: authorName,
                      ),
                      itemCount: apiResponse.data.length,
                    ),
                  );

                case Status.ERROR:
                  return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
