import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:tingla/database/book_schema_to_database.dart';
import 'package:tingla/screens/book_local_open/local_read_book_screen.dart';
import 'package:tingla/screens/category/category_screen.dart';
import 'package:tingla/screens/audio/local_audio_player/local_audio_player_screen.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/audio_player_widget.dart';
import 'package:tingla/widgets/book_image_widget.dart';
import 'package:tingla/widgets/category_widget.dart';

import 'custom_big_button.dart';

class Body extends StatelessWidget {
  final Book book;
  const Body({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      // Scroll qilib olish uchun
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // AppBar orqasidan surish uchun 136.0 px Sizedbox berildi
                const SizedBox(
                  height: 70.0,
                ),
                // Kitob rasmini ochish uchun Container
                BookImageWidget(
                  star: book.rating,
                  imageUrl: book.bookPhoto,
                  title: book.title,
                  author: book.authorName,
                ),
                const SizedBox(
                  height: 50.0,
                ),
                // Padding orqali alohida surish uchun
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionScreenWidth(24.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // KITOB HAQIDA qismi
                      Text(
                        "Kitob haqida",
                        style: TextStyle(
                          fontSize: getProportionScreenWidth(20.0),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: getProportionScreenHeight(16.0),
                      ),
                      // KITOB HAQIDA qisqacha
                      Text(
                        book.description!,
                        maxLines: 50,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: getProportionScreenWidth(16.0),
                          color: Colors.black.withOpacity(.6),
                          height: 1.8,
                        ),
                      ),
                      SizedBox(
                        height: getProportionScreenHeight(40.0),
                      ),
                      // FIKRLAR qismi
                    ],
                  ),
                ),
                // COLLECTION WIDGETLARI
                CollectionWidget(
                  title: "O'xshash kitoblar",
                  id: book.categoryId,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OpenCollectionScreen(
                          title: "O'xshash kitoblar",
                          id: book.categoryId,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: getProportionScreenHeight(40.0),
                ),
                CollectionWidget(
                  title: "Muallifning boshqa kitoblari",
                  id: book.categoryId,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OpenCollectionScreen(
                          title: "Muallifning boshqa kitoblari",
                          id: book.categoryId,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: getProportionScreenHeight(110.0),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const AudioPlayerWidget(),
                SizedBox(
                  width: SizeConfig.screenWidth,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      getProportionScreenWidth(24.0),
                      0,
                      getProportionScreenWidth(24.0),
                      getProportionScreenWidth(30.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomBigButton(
                          icon: 'assets/icons/read_book_icon.svg',
                          text: "O'qish",
                          backgroundColor: const Color(0xFFFD4C45),
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LocalReadBookScreen(
                                  book: book,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: getProportionScreenWidth(10.0)),
                        CustomBigButton(
                          icon: 'assets/icons/seek_icon.svg',
                          text: "Tinglash",
                          backgroundColor: const Color(0xFF0F0F54),
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LocalAudioPlayerScreen(
                                  book: book,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
