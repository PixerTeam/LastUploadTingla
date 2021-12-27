import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tingla/bloc/tingla_cubit.dart';
import 'package:tingla/bloc/tingla_state.dart';
import 'package:tingla/variables/book_theme.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/book_control.dart';
import 'package:tingla/variables/variables.dart';

class Body extends StatefulWidget {
  final BookControl bookControl;
  const Body({
    Key? key,
    required this.bookControl,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    if (widget.bookControl.scrollController!.hasClients) {
      widget.bookControl.progressNotifier.value = BookControlState(
        current: widget.bookControl.scrollController!.offset,
        total: widget.bookControl.scrollController!.position.maxScrollExtent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.bookControl.scrollController,
      padding: EdgeInsets.only(
        left: getProportionScreenHeight(24.0),
        right: getProportionScreenHeight(24.0),
        bottom: getProportionScreenHeight(24.0),
      ),
      itemCount: Variables.openBook!.data!.heads!.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 70.0,
              ),
              // KITOB HAQDIA TEXT
              Text(
                Variables.openBook!.data!.title.toString(),
                style: TextStyle(
                  color: BookTheme.textColor,
                  fontSize: getProportionScreenWidth(24.0),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: getProportionScreenHeight(6.0),
              ),
              Text(
                Variables.openBook!.data!.author!.authorName.toString(),
                style: TextStyle(
                  color: BookTheme.textColor.withOpacity(.6),
                  fontSize: getProportionScreenWidth(18.0),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: getProportionScreenHeight(26.0),
              ),
            ],
          );
        }

        return Text(
          Variables.openBook!.data!.heads![index - 1].body!,
          style: TextStyle(
            fontSize: getProportionScreenWidth(BookTheme.fontSize),
            color: BookTheme.textColor,
            height: 1.7,
          ),
        );
      },
    );
  }

  Widget buildText(int index) {
    return BlocProvider<TinglaCubit>(
      create: (context) => TinglaCubit(const TinglaLoading()),
      child: Builder(
        builder: (context) {
          context
              .read<TinglaCubit>()
              .getHead(Variables.openBook!.data!.heads![index].headId);
          return BlocConsumer<TinglaCubit, TinglaState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is TinglaError) {
                return Text(state.message);
              } else if (state is TinglaCompleted) {
                return Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. ",
                  style: TextStyle(
                    fontSize: getProportionScreenWidth(BookTheme.fontSize),
                    color: BookTheme.textColor,
                    height: 1.7,
                  ),
                );
              }

              return Container();
            },
          );
        },
      ),
    );
  }
}
