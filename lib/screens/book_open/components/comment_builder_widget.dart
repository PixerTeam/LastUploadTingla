import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:tingla/api_functions.dart';
import 'package:tingla/schema/comment_schema.dart';
import 'package:tingla/size_config.dart';

import 'comment_widget.dart';

class CommentBuilder extends StatefulWidget {
  final String bookId;
  const CommentBuilder({Key? key, required this.bookId}) : super(key: key);

  @override
  State<CommentBuilder> createState() => _CommentBuilderState();
}

class _CommentBuilderState extends State<CommentBuilder> {
  int commentCount = 3;
  List commentList = [];

  @override
  void initState() {
    super.initState();
  }

  Stream<List<dynamic>> loadPosts() async* {
    while (true) {
      yield await getComments(widget.bookId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<dynamic>>(
      stream: loadPosts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Column(
            children: [
              Column(
                children: List.generate(
                    commentCount > commentList.length
                        ? commentList.length
                        : commentCount, (index) {
                  Comment comment = Comment.fromJson(commentList[index]);

                  return CommentWidget(
                    index: index,
                    maxIndex: commentCount > commentList.length
                        ? commentList.length
                        : commentCount,
                    comment: comment,
                  );
                }),
              ),
              if (commentList.length > commentCount)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: getProportionScreenHeight(50.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black.withOpacity(.1),
                          elevation: 0.0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                        onPressed: () {
                          int oldComments = commentList.length - commentCount;

                          if (oldComments > 0 && oldComments <= 3) {
                            commentCount += oldComments;
                          } else {
                            commentCount += 3;
                          }

                          setState(() {});
                        },
                        child: Text(
                          "Yana yuklash",
                          style: TextStyle(
                            fontSize: getProportionScreenWidth(18.0),
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          );
        }

        if (snapshot.hasData) {
          commentList = List.from(snapshot.data);
          return Column(
            children: [
              Column(
                children: List.generate(
                    commentCount > snapshot.data.length
                        ? snapshot.data.length
                        : commentCount, (index) {
                  Comment comment = Comment.fromJson(commentList[index]);

                  return CommentWidget(
                    index: index,
                    maxIndex: commentCount > snapshot.data.length
                        ? snapshot.data.length
                        : commentCount,
                    comment: comment,
                  );
                }),
              ),
              if (snapshot.data.length > commentCount)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: getProportionScreenHeight(50.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black.withOpacity(.1),
                          elevation: 0.0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                        onPressed: () {
                          int oldComments = snapshot.data.length - commentCount;

                          if (oldComments > 0 && oldComments <= 3) {
                            commentCount += oldComments;
                          } else {
                            commentCount += 3;
                          }

                          setState(() {});
                        },
                        child: Text(
                          "Yana yuklash",
                          style: TextStyle(
                            fontSize: getProportionScreenWidth(18.0),
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}
