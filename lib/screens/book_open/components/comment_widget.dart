import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/schema/comment_schema.dart';
import 'package:tingla/size_config.dart';

class CommentWidget extends StatefulWidget {
  final Comment comment;
  final int index;
  final int maxIndex;
  const CommentWidget({
    Key? key,
    required this.index,
    required this.maxIndex,
    required this.comment,
  }) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final ValueNotifier<int> _maxLineNotifier = ValueNotifier<int>(3);

  bool _isMax = false;

  @override
  void initState() {
    super.initState();

    if (widget.comment.body!.length < 3 * 50) {
      _isMax = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget userAvatar = Container(
      width: getProportionScreenWidth(40.0),
      height: getProportionScreenWidth(40.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(.1),
      ),
      child: SvgPicture.asset('assets/icons/person_icon.svg',
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionScreenHeight(24.0),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: widget.index != widget.maxIndex - 1
                ? Colors.black.withOpacity(.1)
                : Colors.transparent,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              widget.comment.user!.userPhotos!.isEmpty
                  ? userAvatar
                  : CachedNetworkImage(
                      imageUrl:
                          'https://tingla.pixer.uz/users/photo/${widget.comment.user!.userPhotos![0].file!.photoId}.${widget.comment.user!.userPhotos![0].file!.type}',
                      imageBuilder: (_, imageProvider) => Container(
                        width: getProportionScreenWidth(40.0),
                        height: getProportionScreenWidth(40.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(.1),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        width: getProportionScreenWidth(40.0),
                        height: getProportionScreenWidth(40.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(.1),
                        ),
                      ),
                      placeholder: (_, __) => Container(
                        width: getProportionScreenWidth(40.0),
                        height: getProportionScreenWidth(40.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(.1),
                        ),
                      ),
                    ),
              SizedBox(width: getProportionScreenWidth(12.0)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.comment.user!.name!,
                      style: TextStyle(
                        fontSize: getProportionScreenWidth(18.0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${widget.comment.createdAt!.day < 10 ? "0${widget.comment.createdAt!.day}" : widget.comment.createdAt!.day}/${widget.comment.createdAt!.month < 10 ? "0${widget.comment.createdAt!.month}" : widget.comment.createdAt!.month}/${widget.comment.createdAt!.year}',
                      style: TextStyle(
                        fontSize: getProportionScreenWidth(14.0),
                        color: Colors.black.withOpacity(.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: getProportionScreenHeight(16.0),
          ),
          ValueListenableBuilder(
            valueListenable: _maxLineNotifier,
            builder: (BuildContext _, int _maxLine, Widget? __) {
              return RichText(
                text: TextSpan(
                  text: _setLineComment(),
                  style: TextStyle(
                    fontSize: getProportionScreenWidth(14.0),
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    height: 1.4,
                  ),
                  children: <TextSpan>[
                    if (!_isMax)
                      TextSpan(
                        text: "   Davomi",
                        style: TextStyle(
                          color: const Color(0xFF3243DC),
                          fontSize: getProportionScreenWidth(14.0),
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _isMax = !_isMax;

                            setState(() {});
                          },
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _setLineComment() {
    String _comment = '';

    if (_isMax) {
      _comment = widget.comment.body!;
    } else {
      for (var i = 0; i < 3 * 50; i++) {
        _comment += widget.comment.body![i];
      }

      _comment += '...';
    }

    return _comment;
  }
}
