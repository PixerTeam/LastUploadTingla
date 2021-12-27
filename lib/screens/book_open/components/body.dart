import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:tingla/api_functions.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/screens/audio/network_audio_player/network_audio_player_screen.dart';
import 'package:tingla/screens/book_read/read_book_screen.dart';
import 'package:tingla/screens/category/author_category_widget.dart';
import 'package:tingla/screens/category/category_screen.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';
import 'package:tingla/view_model/network_book_view_model.dart';
import 'package:tingla/widgets/audio_player_widget.dart';
import 'package:tingla/widgets/author_book_widget.dart';
import 'package:tingla/widgets/category_widget.dart';
import 'package:tingla/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../open_book_info_screen.dart';
import '../../../widgets/book_image_widget.dart';
import 'comment_builder_widget.dart';
import 'custom_big_button.dart';
import 'payment_widget.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

  int _star = 0;
  String _commentText = '';
  bool _isChoosed = false;
  bool _fieldActive = false;

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse =
        Provider.of<NetworkBookViewModel>(context).response;
    bool _isSubcriptioned =
        Provider.of<NetworkBookViewModel>(context).isSubcriptioned;

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
                  height: 100.0,
                ),
                // Kitob rasmini ochish uchun Container
                BookImageWidget(
                  star: apiResponse.data!.rating,
                  imageUrl: apiResponse.data!.data!.bookPhoto,
                  title: apiResponse.data!.data!.title,
                  author: apiResponse.data!.data!.author!.authorName,
                ),
                const SizedBox(
                  height: 50.0,
                ),
                // Padding orqali alohida surish uchun
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionScreenWidth(24.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // KITOB HAQIDA qismi
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // KITOB HAQDIA TEXT
                          Text(
                            "Kitob haqida",
                            style: TextStyle(
                              fontSize: getProportionScreenWidth(20.0),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // Button Kirish uchun
                          CustomButton(
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OpenBookInfoScreen(
                                    headsCount: apiResponse.data!.data!.heads !=
                                            null
                                        ? apiResponse.data!.data!.heads!.length
                                            .toString()
                                        : '0',
                                    description:
                                        apiResponse.data!.data!.description ??
                                            "Ma'lumot mavjud emas!",
                                    categoryTitle: apiResponse
                                            .data!.data!.category!.name ??
                                        "Ma'lumot mavjud emas!",
                                    createdAt:
                                        apiResponse.data!.data!.createdAt,
                                  ),
                                ),
                              );
                            },
                            icon: 'assets/icons/next_icon.svg',
                            size: 22.0,
                          ),
                        ],
                      ),
                      // KITOB HAQIDA qisqacha
                      Text(
                        apiResponse.data!.data!.description!,
                        maxLines: 4,
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
                      Text(
                        "Fikrlar",
                        style: TextStyle(
                          fontSize: getProportionScreenWidth(20.0),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (_isSubcriptioned)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: getProportionScreenHeight(16.0),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: const Color(0xFFF7F7F7),
                                border: Border.all(
                                  color: _commentFocusNode.hasFocus
                                      ? Colors.black
                                      : Colors.transparent,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _commentController,
                                      keyboardType: TextInputType.multiline,
                                      cursorColor: Colors.black,
                                      focusNode: _commentFocusNode,
                                      cursorWidth: 1.0,
                                      minLines: 1,
                                      maxLines: 10,
                                      autofocus: false,
                                      autocorrect: true,
                                      style: TextStyle(
                                        fontSize:
                                            getProportionScreenWidth(16.0),
                                        fontWeight: FontWeight.w400,
                                        height: 1.4,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical:
                                              getProportionScreenHeight(10.0),
                                          horizontal:
                                              getProportionScreenWidth(18.0),
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Fikr qoldirish",
                                        hintStyle: TextStyle(
                                          fontSize:
                                              getProportionScreenWidth(16.0),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      onChanged: (text) {
                                        _commentText = text;

                                        bool find = false;
                                        for (String letter in text.split('')) {
                                          if (letter.contains(RegExp(
                                              r"^[a-zA-Z0-9.,()!@#\$%&'\*\+\-\/=\?\^_`{\|}~]+$"))) {
                                            _fieldActive = true;
                                            find = true;
                                          }
                                        }

                                        if (!find) {
                                          _fieldActive = false;
                                        }

                                        setState(() {});
                                      },
                                      onSubmitted: (text) {
                                        _fieldActive = false;

                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  if (_commentFocusNode.hasFocus)
                                    Column(
                                      children: [
                                        SizedBox(
                                          height:
                                              getProportionScreenHeight(7.0),
                                        ),
                                        CustomButton(
                                          icon: 'assets/icons/clear_icon.svg',
                                          press: () async {
                                            _commentController.clear();
                                            _commentFocusNode.unfocus();

                                            _fieldActive = false;

                                            setState(() {});
                                          },
                                          color: Colors.black.withOpacity(.4),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            if (_commentFocusNode.hasFocus && _fieldActive ||
                                _commentController.text.isNotEmpty &&
                                    _fieldActive)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: getProportionScreenHeight(16.0),
                                  ),
                                  SizedBox(
                                    width: getProportionScreenWidth(132.0),
                                    height: getProportionScreenHeight(50.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                      ),
                                      onPressed: () async {
                                        _commentController.clear();
                                        _commentFocusNode.unfocus();

                                        _fieldActive = false;

                                        try {
                                          await sendComment(
                                            _commentText,
                                            apiResponse.data!.data!.id!,
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text('Izoh qoldirildi!'),
                                            ),
                                          );
                                        } catch (e) {
                                          if (e is SocketException) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Ilitimos internetga ulanib qaytadan urinib ko\'ring!'),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(e.toString()),
                                              ),
                                            );
                                          }
                                        }

                                        setState(() {});
                                      },
                                      child: Text(
                                        "Izoh qoldirish",
                                        style: TextStyle(
                                          fontSize:
                                              getProportionScreenWidth(16.0),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(
                              height: getProportionScreenHeight(28.0),
                            ),
                          ],
                        ),

                      // COMMENT WIDGETLARI
                      CommentBuilder(
                        bookId: apiResponse.data!.data!.id!,
                      ),
                      SizedBox(
                        height: getProportionScreenHeight(18.0),
                      ),
                      // REYTINGNI BELGILASH qismi
                      if (apiResponse.data!.userRate != null)
                        if (apiResponse.data!.userRate!.rating == null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: getProportionScreenHeight(20.0),
                              ),
                              Text(
                                "Reytingni belgilash",
                                style: TextStyle(
                                  fontSize: getProportionScreenWidth(20.0),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: getProportionScreenHeight(20.0),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  5,
                                  (index) => CustomButton(
                                    press: () async {
                                      if (!_isChoosed) {
                                        setState(() {
                                          _star = index + 1;
                                        });

                                        try {
                                          await sendRate(
                                            _star,
                                            apiResponse.data!.data!.id!,
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text('Reyting belgilandi!'),
                                            ),
                                          );

                                          _isChoosed = true;

                                          apiResponse.data!.userRate!.rating =
                                              _star;
                                        } catch (e) {
                                          if (e is SocketException) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Ilitimos internetga ulanib qaytadan urinib ko\'ring!'),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(e.toString()),
                                              ),
                                            );
                                          }
                                        }

                                        setState(() {});
                                      }
                                    },
                                    color: _star != 0 && index + 1 <= _star
                                        ? const Color(0xFFFCBD2C)
                                        : Colors.black,
                                    icon: _star != 0 && index + 1 <= _star
                                        ? 'assets/icons/star_fill_icon.svg'
                                        : 'assets/icons/star_icon.svg',
                                    size: getProportionScreenWidth(38.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: getProportionScreenHeight(8.0),
                              ),
                            ],
                          ),
                      // Reyting uchun yulduzcha buttonlar
                    ],
                  ),
                ),
                // COLLECTION WIDGETLARI
                CollectionWidget(
                  textStyle: TextStyle(
                    fontSize: getProportionScreenWidth(20.0),
                    fontWeight: FontWeight.w500,
                  ),
                  title: "O'xshash kitoblar",
                  id: apiResponse.data!.data!.category!.id,
                  press: () {
                    _fieldActive = false;
                    _commentFocusNode.unfocus();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OpenCollectionScreen(
                          title: apiResponse.data!.data!.category!.name,
                          id: apiResponse.data!.data!.category!.id,
                        ),
                      ),
                    );
                  },
                ),
                AuthorBookWidget(
                  title: "Muallifning boshqa kitoblari",
                  authorId: apiResponse.data!.data!.author!.authorId,
                  authorName: apiResponse.data!.data!.author!.authorName,
                  press: () {
                    _fieldActive = false;
                    _commentFocusNode.unfocus();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthorCollectionScreen(
                          title: apiResponse.data!.data!.author!.authorName,
                          authorId: apiResponse.data!.data!.author!.authorId,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: getProportionScreenHeight(120.0),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
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
                            if (!_isSubcriptioned) {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return PaymentWidget(
                                    price: apiResponse.data!.data!.price,
                                    id: apiResponse.data!.data!.id,
                                  );
                                },
                              ).then((v) {
                                if (Variables.isSubcriptioned) {
                                  Provider.of<NetworkBookViewModel>(context,
                                          listen: false)
                                      .getNetworkBook(
                                          id: apiResponse.data!.data!.id);

                                  Variables.isSubcriptioned = false;
                                }
                              });
                            } else {
                              _fieldActive = false;

                              _commentFocusNode.unfocus();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ReadBookScreen(),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(width: getProportionScreenWidth(10.0)),
                        CustomBigButton(
                          icon: 'assets/icons/seek_icon.svg',
                          text: "Tinglash",
                          backgroundColor: const Color(0xFF0F0F54),
                          press: () {
                            if (!_isSubcriptioned) {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return PaymentWidget(
                                    price: apiResponse.data!.data!.price,
                                    id: apiResponse.data!.data!.id,
                                  );
                                },
                              ).then((v) {
                                if (Variables.isSubcriptioned) {
                                  Provider.of<NetworkBookViewModel>(context,
                                          listen: false)
                                      .getNetworkBook(
                                          id: apiResponse.data!.data!.id);

                                  Variables.isSubcriptioned = false;
                                }
                              });
                            } else {
                              _fieldActive = false;

                              _commentFocusNode.unfocus();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AudioPlayerScreen(
                                    book: apiResponse.data,
                                  ),
                                ),
                              ).then((value) {
                                Provider.of<NetworkBookViewModel>(context,
                                        listen: false)
                                    .checkIsSaved(
                                        id: apiResponse.data!.data!.id!);
                                Provider.of<NetworkBookViewModel>(context,
                                        listen: false)
                                    .checkIsDownloaded(
                                        id: apiResponse.data!.data!.id!);
                              });
                            }
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
