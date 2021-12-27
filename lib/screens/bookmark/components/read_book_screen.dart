import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tingla/bloc/tingla_cubit.dart';
import 'package:tingla/bloc/tingla_state.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/database/book_schema_to_database.dart';
import 'package:tingla/schema/cache_book_schema.dart';
import 'package:tingla/screens/book_local_open/local_book_screen.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';

import 'read_not_screen.dart';

enum BookType { read, listen }

class Read extends StatefulWidget {
  const Read({Key? key}) : super(key: key);

  @override
  State<Read> createState() => _ReadState();
}

class _ReadState extends State<Read> {

  List icon = [
    Icons.headphones_outlined,
    CupertinoIcons.book,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TinglaCubit>(
      create: (context) => TinglaCubit(const TinglaLoading()),
      child: Builder(builder: (context) {
        context.read<TinglaCubit>().getReadBooks();
        return BlocConsumer<TinglaCubit, TinglaState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is TinglaError) {
              return const ReadNotScreen();
            } else if (state is TinglaCompleted) {
              List<CacheBook> cachedBooks = [];
              if (state.response != null) {
                for (CacheBook cacheBook in state.response) {
                  if (cacheBook.headCurrentOffset != 0 ||
                      cacheBook.audioCurrentOffset != 0) {
                    cachedBooks.add(cacheBook);
                  }
                }
              }

              if (cachedBooks.isEmpty) {
                return const ReadNotScreen();
              }

              return ListView.builder(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: cachedBooks.length,
                itemBuilder: (context, index) {
                  CacheBook cacheBook = cachedBooks[index];
                  BookType _type;
                  int _pracent = 0;
                  int _headPracent =
                      (cacheBook.headCurrentOffset.toDouble() == 0.0
                              ? 0.0
                              : cacheBook.headCurrentOffset.toDouble() /
                                  cacheBook.headMaxOffset.toDouble() *
                                  100)
                          .round();

                  int _audioPracent = (cacheBook.audioCurrentOffset == 0
                          ? 0
                          : cacheBook.audioCurrentOffset /
                              cacheBook.audioMaxOffset *
                              100)
                      .round();

                  if (_headPracent > _audioPracent) {
                    _pracent = _headPracent;
                    _type = BookType.read;
                  } else {
                    _pracent = _audioPracent;
                    _type = BookType.listen;
                  }

                  if (cacheBook.headCurrentOffset != 0 ||
                      cacheBook.audioCurrentOffset != 0) {
                    return FutureBuilder(
                        future: Variables.databaseHelper!.findQuery(
                          cacheBook.bookId,
                          table: 'book',
                        ),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            Book _book = snapshot.data[0];
                            return InkWell(
                              onTap: () async {
                                Variables.localBook = _book;

                                bool isExist = await Variables.databaseHelper!
                                    .isExist(_book.id!, table: 'book');

                                if (isExist) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const LocalBookScreen(),
                                    ),
                                  ).then((value) {
                                    setState(() {});
                                  });
                                } else {
                                  context
                                      .read<TinglaCubit>()
                                      .getDownloadBooks();
                                }
                              },
                              child: Container(
                                color: Colors.black.withOpacity(.02),
                                height: getProportionScreenHeight(244.0),
                                padding: EdgeInsets.only(
                                  left: getProportionScreenWidth(24.0),
                                  right: getProportionScreenWidth(24.0),
                                  top: getProportionScreenHeight(16.0),
                                  bottom: getProportionScreenHeight(16.0),
                                ),
                                margin: EdgeInsets.only(
                                  bottom: getProportionScreenHeight(16.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _type == BookType.read
                                          ? "O'qilayotgan"
                                          : "Tinglanayotgan",
                                      style: TextStyle(
                                        color: kTextColor.withOpacity(.6),
                                        fontSize:
                                            getProportionScreenWidth(16.0),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            getProportionScreenHeight(16.0)),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: _book.bookPhoto ?? '',
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: getProportionScreenWidth(
                                                  110.0),
                                              padding: EdgeInsets.all(
                                                  getProportionScreenHeight(
                                                      4.0)),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                height:
                                                    getProportionScreenHeight(
                                                        30.0),
                                                width: getProportionScreenWidth(
                                                    30.0),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  _type == BookType.read
                                                      ? CupertinoIcons.book
                                                      : Icons
                                                          .headphones_outlined,
                                                  size:
                                                      getProportionScreenWidth(
                                                          18.0),
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            errorWidget: (_, __, ___) =>
                                                Container(
                                              width: getProportionScreenWidth(
                                                  110.0),
                                              padding: EdgeInsets.all(
                                                  getProportionScreenHeight(
                                                      4.0)),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                height:
                                                    getProportionScreenHeight(
                                                        30.0),
                                                width: getProportionScreenWidth(
                                                    30.0),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  icon[0],
                                                  size:
                                                      getProportionScreenWidth(
                                                          18.0),
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            placeholder: (_, __) => Container(
                                              width: getProportionScreenWidth(
                                                  110.0),
                                              padding: EdgeInsets.all(
                                                  getProportionScreenHeight(
                                                      4.0)),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                height:
                                                    getProportionScreenHeight(
                                                        30.0),
                                                width: getProportionScreenWidth(
                                                    30.0),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  icon[0],
                                                  size:
                                                      getProportionScreenWidth(
                                                          18.0),
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              width: getProportionScreenWidth(
                                                  20.0)),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height:
                                                      getProportionScreenHeight(
                                                          3.0)),
                                              Text(
                                                _book.title!,
                                                style: TextStyle(
                                                  fontSize:
                                                      getProportionScreenWidth(
                                                          24.0),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                  height:
                                                      getProportionScreenHeight(
                                                          8.0)),
                                              Text(
                                                _book.description!,
                                                style: TextStyle(
                                                  fontSize:
                                                      getProportionScreenWidth(
                                                          16.0),
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              const Spacer(),
                                              LinearPercentIndicator(
                                                padding: EdgeInsets.zero,
                                                width: getProportionScreenWidth(
                                                    164.0),
                                                lineHeight:
                                                    getProportionScreenHeight(
                                                        5.0),
                                                percent: _type == BookType.read
                                                    ? cacheBook
                                                            .headCurrentOffset /
                                                        cacheBook
                                                            .headMaxOffset *
                                                        1.0
                                                    : cacheBook
                                                            .audioCurrentOffset /
                                                        cacheBook
                                                            .audioMaxOffset *
                                                        1.0,
                                                backgroundColor:
                                                    Colors.grey.shade200,
                                                progressColor:
                                                    const Color(0xFFFCBD2C),
                                              ),
                                              SizedBox(
                                                  height:
                                                      getProportionScreenHeight(
                                                          8.0)),
                                              Text(
                                                "$_pracent% tugatilgan",
                                                style: TextStyle(
                                                  fontSize:
                                                      getProportionScreenWidth(
                                                          14.0),
                                                  color: kTextColor,
                                                ),
                                              ),
                                              SizedBox(
                                                  height:
                                                      getProportionScreenHeight(
                                                          13.0)),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        });
                  }

                  return const SizedBox();
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      }),
    );
  }
}
