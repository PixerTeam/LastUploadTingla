import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tingla/bloc/tingla_cubit.dart';
import 'package:tingla/bloc/tingla_state.dart';
import 'package:tingla/schema/cache_book_schema.dart';
import 'package:tingla/variables/book_control.dart';
import 'package:tingla/variables/book_theme.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/custom_button.dart';
import 'package:tingla/database/book_schema_to_database.dart' as bookSchema;
import 'package:tingla/widgets/loading_widget.dart';

import '../book_read/components/custom_bottom_slider.dart';
import '../book_read/components/read_book_settings_widget.dart';

class LocalReadBookScreen extends StatefulWidget {
  final bookSchema.Book book;
  const LocalReadBookScreen({Key? key, required this.book}) : super(key: key);

  @override
  _ReadBookScreenState createState() => _ReadBookScreenState();
}

class _ReadBookScreenState extends State<LocalReadBookScreen> {
  void callback({size, tag}) {
    if (tag == "dark") {
      if (BookTheme.themeMode) {
        setState(() {
          BookTheme().changeTheme();
        });
      }
    } else if (tag == "light") {
      if (!BookTheme.themeMode) {
        setState(() {
          BookTheme().changeTheme();
        });
      }
    }

    if (size != null) {
      setState(() {
        BookTheme.fontSize = size;
      });
    }
  }

  CacheBook? _cacheBook;
  final BookControl _bookControl = BookControl();

  @override
  Widget build(BuildContext context) {
    Widget buildWidget = Scaffold(
      backgroundColor: BookTheme.backgroundColor,
      body: SafeArea(
        child: BlocProvider<TinglaCubit>(
          create: (context) => TinglaCubit(const TinglaLoading()),
          child: Builder(builder: (context) {
            context.read<TinglaCubit>().getCacheBook(widget.book.id);

            return BlocConsumer<TinglaCubit, TinglaState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is TinglaError) {
                  return const Center(
                    child: Text(
                        'Ayrim sabablarga ko\'rabu kitobni ochib bo\'lmaydi'),
                  );
                }

                if (state is TinglaCompleted) {
                  _cacheBook = state.response;

                  return WillPopScope(
                    onWillPop: () async {
                      _cacheBook!.headCurrentOffset =
                          _bookControl.scrollController!.offset;

                      _cacheBook!.headMaxOffset = _bookControl
                          .scrollController!.position.maxScrollExtent;

                      await Variables.databaseHelper!
                          .update(_cacheBook, table: 'cache');

                      return true;
                    },
                    child: Stack(
                      children: [
                        BlocProvider<TinglaCubit>(
                          create: (context) =>
                              TinglaCubit(const TinglaLoading()),
                          child: Builder(builder: (context) {
                            context
                                .read<TinglaCubit>()
                                .getBookHeads(widget.book.id!);

                            return BlocConsumer<TinglaCubit, TinglaState>(
                              builder: (context, state) {
                                if (state is TinglaError) {}

                                if (state is TinglaCompleted) {
                                  List<bookSchema.Head> _heads = state.response;

                                  return ListView.builder(
                                    controller: _bookControl.scrollController,
                                    padding: EdgeInsets.only(
                                      left: getProportionScreenHeight(24.0),
                                      right: getProportionScreenHeight(24.0),
                                      bottom: getProportionScreenHeight(24.0),
                                    ),
                                    itemCount: _heads.length,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 70.0,
                                            ),
                                            // KITOB HAQDIA TEXT
                                            Text(
                                              widget.book.title!,
                                              style: TextStyle(
                                                color: BookTheme.textColor,
                                                fontSize:
                                                    getProportionScreenWidth(
                                                        24.0),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: getProportionScreenHeight(
                                                  6.0),
                                            ),
                                            Text(
                                              widget.book.authorName!,
                                              style: TextStyle(
                                                color: BookTheme.textColor
                                                    .withOpacity(.6),
                                                fontSize:
                                                    getProportionScreenWidth(
                                                        18.0),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(
                                              height: getProportionScreenHeight(
                                                  26.0),
                                            ),
                                          ],
                                        );
                                      }

                                      return Text(
                                        _heads[index].body.toString(),
                                        style: TextStyle(
                                          fontSize: getProportionScreenWidth(
                                              BookTheme.fontSize),
                                          color: BookTheme.textColor,
                                          height: 1.7,
                                        ),
                                      );
                                    },
                                  );
                                }

                                return const SizedBox();
                              },
                              listener: (context, state) {},
                            );
                          }),
                        ),
                        CustomAppBar(
                          backgroundColor: BookTheme.backgroundColor,
                          child: Row(
                            children: [
                              CustomButton(
                                press: () async {
                                  _cacheBook!.headCurrentOffset =
                                      _bookControl.scrollController!.offset;

                                  _cacheBook!.headMaxOffset = _bookControl
                                      .scrollController!
                                      .position
                                      .maxScrollExtent;

                                  await Variables.databaseHelper!
                                      .update(_cacheBook, table: 'cache');

                                  Navigator.pop(context);
                                },
                                icon: 'assets/icons/back_icon.svg',
                                color: BookTheme.textColor,
                              ),
                              const Spacer(),
                              CustomButton(
                                press: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) =>
                                        ReadBookSettingsWidget(
                                            callback: callback),
                                  );
                                },
                                color: BookTheme.textColor,
                                icon: 'assets/icons/settings_icon.svg',
                              ),
                              SizedBox(
                                width: getProportionScreenWidth(16.0),
                              ),
                              CustomButton(
                                press: () {},
                                color: BookTheme.textColor,
                                icon: 'assets/icons/share_icon.svg',
                              ),
                            ],
                          ),
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: _bookControl.scrolNotifier,
                          builder: (_, value, __) {
                            return AnimatedPositioned(
                              duration: const Duration(milliseconds: 200),
                              bottom: value ? 0 : -100.0,
                              child: CustomBottomSlider(
                                bookControl: _bookControl,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
                return const LoadingWidget();
              },
            );
          }),
        ),
      ),
    );

    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      _bookControl.setOffset(_cacheBook);
    });

    return buildWidget;
  }
}
