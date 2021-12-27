import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/bloc/tingla_cubit.dart';
import 'package:tingla/bloc/tingla_state.dart';
import 'package:tingla/model/page_manager.dart';
import 'package:tingla/model/services/service_locator.dart';
import 'package:tingla/screens/book_local_open/local_book_screen.dart';
import 'package:tingla/size_config.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tingla/variables/variables.dart';
import 'download_not_screen.dart';

class Download extends StatefulWidget {
  const Download({Key? key}) : super(key: key);

  @override
  _DownloadState createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  final items = List<String>.generate(2, (i) => 'Item ${i + 1}');

  SlidableController? _slidableController;

  @override
  void initState() {
    _slidableController = SlidableController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return BlocProvider<TinglaCubit>(
      create: (context) => TinglaCubit(const TinglaLoading()),
      child: Builder(builder: (context) {
        context.read<TinglaCubit>().getDownloadBooks();
        return BlocConsumer<TinglaCubit, TinglaState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is TinglaError) {
              return const DownloadNotScreen();
            } else if (state is TinglaCompleted) {
              if (Variables.localBooks.isEmpty) {
                return const DownloadNotScreen();
              }

              return ListView.builder(
                padding:
                    EdgeInsets.only(bottom: getProportionScreenHeight(110.0)),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: Variables.localBooks.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Slidable(
                        controller: _slidableController,
                        actionPane: const SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: InkWell(
                          onTap: () async {
                            Variables.localBook = Variables.localBooks[index];
                            
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const LocalBookScreen();
                                },
                              ),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                          child: Container(
                            height: getProportionScreenHeight(138.0),
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionScreenWidth(24.0),
                              vertical: getProportionScreenHeight(10.0),
                            ),
                            color: Colors.black.withOpacity(.02),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CachedNetworkImage(
                                  fadeInDuration: Duration.zero,
                                  fadeOutDuration: Duration.zero,
                                  imageUrl:
                                      Variables.localBooks[index].bookPhoto ??
                                          '',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: getProportionScreenWidth(81.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.withOpacity(.2),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (_, __, ___) => Container(
                                    width: getProportionScreenWidth(81.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.withOpacity(.2),
                                    ),
                                  ),
                                  placeholder: (_, __) => Container(
                                    width: getProportionScreenWidth(81.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.withOpacity(.2),
                                    ),
                                  ),
                                ),
                                SizedBox(width: getProportionScreenWidth(16.0)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        height:
                                            getProportionScreenHeight(14.0)),
                                    Text(
                                      Variables.localBooks[index].title!,
                                      style: TextStyle(
                                        fontSize:
                                            getProportionScreenWidth(18.0),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                        height: getProportionScreenHeight(4.0)),
                                    Text(
                                      Variables.localBooks[index].authorName!,
                                      style: TextStyle(
                                          fontSize:
                                              getProportionScreenWidth(14.0),
                                          color: Colors.grey.shade700),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/check_icon.svg',
                                          width: getProportionScreenWidth(18.0),
                                          height:
                                              getProportionScreenWidth(18.0),
                                          color: const Color(0xFF4FBF67),
                                        ),
                                        SizedBox(
                                          width:
                                              getProportionScreenHeight(8.25),
                                        ),
                                        Text(
                                          "Yuklangan",
                                          style: TextStyle(
                                            fontSize:
                                                getProportionScreenWidth(16),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: getProportionScreenHeight(
                                        18.0,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        secondaryActions: <Widget>[
                          ValueListenableBuilder(
                              valueListenable: pageManager.audioActiveNotifier,
                              builder: (_, bool active, __) {
                                return GestureDetector(
                                  onTap: () async {
                                    bool failed = false;
                                    String currentBookId = 'l' +
                                        Variables.localBooks[index].id
                                            .toString();

                                    if (active) {
                                      if (pageManager.currentBookId ==
                                          currentBookId) {
                                        failed = true;
                                      }
                                    }

                                    if (!failed) {
                                      try {
                                        await Variables.databaseHelper!.delete(
                                          Variables.localBooks[index].id,
                                          table: "book",
                                        );

                                        await Variables.databaseHelper!.delete(
                                          Variables.localBooks[index].id,
                                          table: "cache",
                                        );
                                      } catch (e) {
                                        _showSnackBar();
                                      }

                                      context
                                          .read<TinglaCubit>()
                                          .getDownloadBooks();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Bu kitobni o\'chirib bo\'lmadi, kitob tinglanmoqda!'),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    color: Colors.red,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/trash_icon.svg',
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height:
                                              getProportionScreenHeight(8.0),
                                        ),
                                        Text(
                                          "O'chirish",
                                          style: TextStyle(
                                            fontSize:
                                                getProportionScreenWidth(16.0),
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                      SizedBox(height: getProportionScreenHeight(12.0)),
                    ],
                  );
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

  _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: getProportionScreenWidth(151.0),
        padding: EdgeInsets.symmetric(vertical: getProportionScreenWidth(12.0)),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline_outlined,
              color: Colors.green,
              size: getProportionScreenWidth(18.0),
            ),
            SizedBox(width: getProportionScreenWidth(8.25)),
            Text(
              'Fayl o’chirildi',
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionScreenWidth(16.0),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}
