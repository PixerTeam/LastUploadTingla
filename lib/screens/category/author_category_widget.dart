import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tingla/bloc/tingla_cubit.dart';
import 'package:tingla/bloc/tingla_state.dart';
import 'package:tingla/schema/author_book_schema.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/audio_player_widget.dart';
import 'package:tingla/widgets/category_item_widget.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/custom_button.dart';

import '../details/connection_error_screen.dart';
import 'components/loading_category_screen.dart';

// ignore: must_be_immutable
class AuthorCollectionScreen extends StatelessWidget {
  final String? title;
  final String? authorId;

  const AuthorCollectionScreen(
      {Key? key, required this.title, required this.authorId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BlocProvider<TinglaCubit>(
              create: (context) => TinglaCubit(const TinglaLoading()),
              child: Builder(builder: (context) {
                context.read<TinglaCubit>().getAuthorCategory(authorId);

                return BlocConsumer<TinglaCubit, TinglaState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is TinglaError) {
                      return ConnectionErrorScreen(
                        press: () {
                          context.read<TinglaCubit>().getAuthorCategory(authorId);
                        },
                      );
                    }

                    if (state is TinglaCompleted) {
                      List<AuthorBook> authorBooks = state.response;

                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                          left: getProportionScreenWidth(24.0),
                          top: 90.0,
                          right: getProportionScreenWidth(8.0),
                          bottom: getProportionScreenHeight(24.0),
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: getProportionScreenWidth(24.0),
                          mainAxisExtent: getProportionScreenHeight(213.0),
                        ),
                        itemCount: authorBooks.length,
                        itemBuilder: (context, index) {
                          return ItemWidget(book: authorBooks[index]);
                        },
                      );
                    }

                    return const LoadingCategoryScreen();
                  },
                );
              }),
            ),
            CustomAppBar(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomButton(
                    icon: 'assets/icons/back_icon.svg',
                    press: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: getProportionScreenWidth(6.0)),
                  Expanded(
                    child: Text(
                      title!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: getProportionScreenWidth(24.0),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 0,
              child: AudioPlayerWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
