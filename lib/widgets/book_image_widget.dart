import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/size_config.dart';

class BookImageWidget extends StatelessWidget {
  final int? star;
  final String? imageUrl;
  final String? title;
  final String? author;
  const BookImageWidget({
    Key? key,
    this.star,
    required this.imageUrl,
    required this.title,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: getProportionScreenHeight(28.0),
                right: getProportionScreenWidth(33.0),
                left: getProportionScreenWidth(33.0),
              ),
              child: CachedNetworkImage(
                placeholderFadeInDuration: Duration.zero,
                fadeInDuration: Duration.zero,
                fadeOutDuration: Duration.zero,
                imageUrl: imageUrl ?? '',
                imageBuilder: (context, imageProvider) => Container(
                  width: getProportionScreenWidth(182.0),
                  height: getProportionScreenHeight(264.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Colors.grey.withOpacity(.2),
                    image: DecorationImage(
                      // Kitob rasmi
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                errorWidget: (context, error, imageProvider) => Container(
                  width: getProportionScreenWidth(182.0),
                  height: getProportionScreenHeight(264.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Colors.grey.withOpacity(.2),
                  ),
                ),
                placeholder: (context, imageProvider) => Container(
                  width: getProportionScreenWidth(182.0),
                  height: getProportionScreenHeight(264.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Colors.grey.withOpacity(.2),
                  ),
                ),
              ),
            ),
            if (star != null) Positioned(
              top: getProportionScreenHeight(11),
              right: getProportionScreenWidth(0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.black,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/star_fill_icon.svg',
                      width: 14.0,
                      height: 14.0,
                    ),
                    SizedBox(
                      width: getProportionScreenWidth(4.0),
                    ),
                    Text(
                      star.toString(),
                      style: TextStyle(
                        fontSize: getProportionScreenWidth(16.0),
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: getProportionScreenHeight(28.0),
        ),
        Text(
          title ?? 'Topilmadi',
          style: TextStyle(
            fontSize: getProportionScreenWidth(24.0),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: getProportionScreenHeight(8.0),
        ),
        Text(
          author ?? 'Topilmadi',
          style: TextStyle(
            fontSize: getProportionScreenWidth(16.0),
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
