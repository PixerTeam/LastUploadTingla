import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tingla/bloc/tingla_cubit.dart';
import 'package:tingla/bloc/tingla_state.dart';
import 'package:tingla/schema/one_category_schema.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/audio_player_widget.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/custom_button.dart';

import '../details/connection_error_screen.dart';
import 'components/body.dart';
import 'components/loading_category_screen.dart';

// ignore: must_be_immutable
class OpenCollectionScreen extends StatelessWidget {
  final String? title;
  final String? id;

  OpenCollectionScreen({Key? key, required this.title, required this.id})
      : super(key: key);

  late OneCategory _oneCategory;

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
                context.read<TinglaCubit>().getOneCategory(id);

                return BlocConsumer<TinglaCubit, TinglaState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is TinglaError) {
                      return ConnectionErrorScreen(
                        press: () {
                          context.read<TinglaCubit>().getOneCategory(id);
                        },
                      );
                    }

                    if (state is TinglaCompleted) {
                      _oneCategory = state.response;
                      return Body(oneCategory: _oneCategory);
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
