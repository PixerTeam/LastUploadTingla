import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/schema/subcription_schema.dart';
import 'package:tingla/size_config.dart';

class Carditem extends StatelessWidget {
  const Carditem({
    Key? key,
    required this.subcription,
  }) : super(key: key);

  final Subcription subcription;

  @override
  Widget build(BuildContext context) {
    String createdAtString = "Ma'lumot mavjud emas!";

    if (subcription.createdAt != null) {
      createdAtString =
          '${subcription.createdAt!.day < 10 ? "0${subcription.createdAt!.day}" : subcription.createdAt!.day}.${subcription.createdAt!.month < 10 ? "0${subcription.createdAt!.month}" : subcription.createdAt!.month}.${subcription.createdAt!.year}';
    }

    return Container(
      color: const Color(0xFFFAFAFA),
      height: getProportionScreenHeight(240.0),
      child: Padding(
        padding: EdgeInsets.only(
          left: getProportionScreenWidth(24.0),
          right: getProportionScreenWidth(24.0),
          top: getProportionScreenHeight(16.0),
          bottom: getProportionScreenHeight(16.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Audio kitob",
                  style: TextStyle(
                    fontSize: getProportionScreenWidth(16.0),
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  createdAtString,
                  style: TextStyle(
                      fontSize: getProportionScreenWidth(16.0),
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: getProportionScreenHeight(16.0),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CachedNetworkImage(
                    fadeInDuration: Duration.zero,
                    fadeOutDuration: Duration.zero,
                    placeholderFadeInDuration: Duration.zero,
                    imageUrl: subcription.book!.bookPhoto ?? '',
                    imageBuilder: (context, imageProvider) => Container(
                      width: getProportionScreenWidth(110.0),
                      padding: EdgeInsets.all(getProportionScreenHeight(4.0)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.topRight,
                      child: Container(
                        height: getProportionScreenHeight(30.0),
                        width: getProportionScreenWidth(30.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.headphones_outlined,
                          size: getProportionScreenWidth(18.0),
                          color: Colors.black,
                        ),
                      ),
                    ),
                    errorWidget: (context, error, widget) => Container(
                      width: getProportionScreenWidth(110.0),
                      padding: EdgeInsets.all(getProportionScreenHeight(4.0)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200,
                      ),
                      alignment: Alignment.topRight,
                      child: Container(
                        height: getProportionScreenHeight(30.0),
                        width: getProportionScreenWidth(30.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.headphones_outlined,
                          size: getProportionScreenWidth(18.0),
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getProportionScreenWidth(20.0),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionScreenHeight(14.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subcription.book!.title.toString(),
                            style: TextStyle(
                              fontSize: getProportionScreenWidth(24.0),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: getProportionScreenHeight(8.0),
                          ),
                          Text(
                            subcription.book!.author!.authorName.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: getProportionScreenWidth(16.0),
                              color: kTextColor.withOpacity(.8),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "${subcription.book!.price} UZS",
                            style: TextStyle(
                                fontSize: getProportionScreenWidth(20.0),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
