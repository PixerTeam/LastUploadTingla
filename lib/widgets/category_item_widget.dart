import 'package:flutter/material.dart';
import 'package:tingla/schema/book_schema.dart' as savedBook;
import 'package:tingla/screens/book_open/book_info_screen.dart';
import 'package:tingla/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemWidget extends StatelessWidget {
  final dynamic book;
  final String? authorName;

  const ItemWidget({
    Key? key,
    required this.book,
    this.authorName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookInfoScreen(
              id: book.id,
              data: book,
            ),
          ),
        );
      },
      child: Container(
        width: getProportionScreenWidth(110.0),
        margin: EdgeInsets.only(right: getProportionScreenWidth(16.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CachedNetworkImage(
                fadeInDuration: Duration.zero,
                fadeOutDuration: Duration.zero,
                placeholderFadeInDuration: Duration.zero,
                imageUrl: book.bookPhoto ?? '',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                errorWidget: (context, error, widget) => Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: getProportionScreenHeight(8.0)),
            Text(
              book.title!,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: getProportionScreenHeight(8.0)),
            Text(
              authorName != null ? authorName.toString() : book is savedBook.SavedBook ? book.authorName : book.author.authorName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: getProportionScreenWidth(12.0),
                color: Colors.black.withOpacity(.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
