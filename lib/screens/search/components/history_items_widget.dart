import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/bloc/tingla_cubit.dart';
import 'package:tingla/bloc/tingla_state.dart';
import 'package:tingla/variables/search_variables.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';

class HistoryItemWidget extends StatefulWidget {
  const HistoryItemWidget({Key? key}) : super(key: key);

  @override
  _HistoryItemWidgetState createState() => _HistoryItemWidgetState();
}

class _HistoryItemWidgetState extends State<HistoryItemWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TinglaCubit>(
      create: (context) => TinglaCubit(const TinglaCompleted()),
      child: Builder(
        builder: (context) {
          context.read<TinglaCubit>().getSearchHistory();
          return BlocConsumer<TinglaCubit, TinglaState>(
            builder: (context, state) {
              if (state is TinglaError) {
                return Container();
              }

              if (state is TinglaCompleted) {
                List<String> _history = state.response;
                return Padding(
                  padding: EdgeInsets.only(
                    left: getProportionScreenWidth(24.0),
                    top: getProportionScreenHeight(24.0),
                    right: getProportionScreenWidth(24.0),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 80.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _history.isNotEmpty
                                ? "So'nggi qidiruvlar"
                                : "So'nggi qidiruvlar mavjud emas",
                            style: TextStyle(
                              fontSize: getProportionScreenWidth(16.0),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (_history.isNotEmpty)
                            GestureDetector(
                              onTap: () async {
                                await Variables.databaseHelper!
                                    .deleteRow(table: 'history');

                                context.read<TinglaCubit>().getSearchHistory();
                              },
                              child: Text(
                                "Tozalash",
                                style: TextStyle(
                                  color: const Color(0xFF3243DC),
                                  fontSize: getProportionScreenWidth(16.0),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: getProportionScreenHeight(12.0)),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.only(
                            bottom: getProportionScreenHeight(120.0),
                          ),
                          itemCount: _history.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                SearchVariables.onHistory(_history[index]);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: getProportionScreenHeight(8.0),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/history_clock_icon.svg',
                                      width: getProportionScreenWidth(22.0),
                                      height: getProportionScreenWidth(22.0),
                                    ),
                                    SizedBox(
                                        width: getProportionScreenWidth(12.0)),
                                    Expanded(
                                      child: Text(
                                        _history[index],
                                        style: TextStyle(
                                          fontSize:
                                              getProportionScreenWidth(18.0),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: getProportionScreenWidth(12.0)),
                                    GestureDetector(
                                      onTap: () {
                                        Variables.databaseHelper!.delete(
                                          _history[index],
                                          table: 'history',
                                        );

                                        context
                                            .read<TinglaCubit>()
                                            .getSearchHistory();
                                      },
                                      child: SvgPicture.asset(
                                        'assets/icons/clear_icon.svg',
                                        width: getProportionScreenWidth(30.0),
                                        height: getProportionScreenWidth(30.0),
                                        color: Colors.black.withOpacity(.4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
            listener: (context, statae) {},
          );
        },
      ),
    );
  }
}
