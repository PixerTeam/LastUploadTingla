import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tingla/bloc/tingla_cubit.dart';
import 'package:tingla/bloc/tingla_state.dart';
import 'package:tingla/screens/bookmark/components/saved_not_screen.dart';
import 'package:tingla/widgets/category_item_widget.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';

class SavedWidget extends StatelessWidget {
  const SavedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TinglaCubit>(
      create: (context) => TinglaCubit(const TinglaLoading()),
      child: Builder(builder: (context) {
        context.read<TinglaCubit>().getSavedBooks();

        return BlocConsumer<TinglaCubit, TinglaState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is TinglaError) {
              return const SavedNotScreen();
            } else if (state is TinglaCompleted) {
              if (Variables.savedBooks.isEmpty) {
                return const SavedNotScreen();
              }

              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionScreenWidth(24.0),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: getProportionScreenWidth(18.0),
                  mainAxisExtent: getProportionScreenHeight(222.0),
                  mainAxisSpacing: getProportionScreenWidth(18.0),
                ),
                itemCount: Variables.savedBooks.length,
                itemBuilder: (context, index) {
                  return ItemWidget(book: Variables.savedBooks[index]);
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          },
        );
      }),
    );
  }
}
