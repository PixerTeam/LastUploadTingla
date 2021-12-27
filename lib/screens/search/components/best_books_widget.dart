import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tingla/bloc/tingla_cubit.dart';
import 'package:tingla/bloc/tingla_state.dart';
import 'package:tingla/screens/details/connection_error_screen.dart';
import 'package:tingla/widgets/category_item_widget.dart';
import 'package:tingla/screens/search/components/best_books_loading_widget.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';

class DefaultItemsWidget extends StatelessWidget {
  const DefaultItemsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TinglaCubit>(
      create: (context) => TinglaCubit(
        Variables.bestBooks.isEmpty
            ? const TinglaLoading()
            : const TinglaCompleted(),
      ),
      child: Builder(
        builder: (context) {
          if (Variables.bestBooks.isEmpty) {
            context.read<TinglaCubit>().getBestBooks();
          }
          return BlocConsumer<TinglaCubit, TinglaState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is TinglaError) {
                return ConnectionErrorScreen(
                  press: () => context.read<TinglaCubit>().getBestBooks(),
                );
              } else if (state is TinglaCompleted) {
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: EdgeInsets.only(
                              left: getProportionScreenWidth(24.0),
                              top: getProportionScreenHeight(24.0),
                              right: getProportionScreenWidth(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 70.0),
                                Text(
                                  "Ko'p qidirilgan kitoblar",
                                  style: TextStyle(
                                    fontSize: getProportionScreenWidth(20.0),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                    height: getProportionScreenHeight(24.0)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(
                        left: getProportionScreenWidth(24.0),
                        right: getProportionScreenWidth(8.0),
                      ),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: getProportionScreenWidth(24.0),
                          mainAxisExtent: getProportionScreenHeight(213.0),
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ItemWidget(book: Variables.bestBooks[index]);
                          },
                          childCount: Variables.bestBooks.length,
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SizedBox(height: getProportionScreenHeight(100.0)),
                        ],
                      ),
                    ),
                  ],
                );
              }

              return const LoadingBestBooks();
            },
          );
        },
      ),
    );
  }
}
