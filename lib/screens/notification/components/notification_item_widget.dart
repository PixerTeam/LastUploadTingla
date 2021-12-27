import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tingla/size_config.dart';

class NotificationItemWidget extends StatelessWidget {
  final tag;
  final title;
  final subtitle;
  final body;
  final newItem;
  const NotificationItemWidget({
    Key? key,
    this.tag,
    this.title,
    this.subtitle,
    this.body,
    this.newItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _image;

    if (tag == "happy") {
      _image = 'assets/icons/happy_icon.svg';
    } else if (tag == "complect") {
      _image = 'assets/icons/complect_icon.svg';
    } else if (tag == "warning") {
      _image = 'assets/icons/warning_icon.svg';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: getProportionScreenWidth(10.0)),
      margin: EdgeInsets.only(bottom: getProportionScreenHeight(12.0)),
      child: Row(
        children: [
          newItem
              ? Icon(
                  Icons.circle,
                  color: const Color(0xFFFD4C45),
                  size: getProportionScreenWidth(8.0),
                )
              : SizedBox(width: getProportionScreenWidth(8.0)),
          SizedBox(width: getProportionScreenWidth(6.0)),
          Expanded(
            child: Container(
              height: getProportionScreenHeight(90.0),
              padding: EdgeInsets.all(getProportionScreenWidth(10.0)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFFF9F9F9),
              ),
              child: Row(
                children: [
                  Container(
                    width: getProportionScreenWidth(70),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFFF4E1E1),
                    ),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: getProportionScreenWidth(32.0),
                      height: getProportionScreenHeight(32.0),
                      child: SvgPicture.asset(_image),
                    ),
                  ),
                  SizedBox(width: getProportionScreenWidth(16.0)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: getProportionScreenWidth(16.0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: getProportionScreenHeight(8.0)),
                        if (body.length != 0)
                          Column(
                            children: [
                              Text(
                                body,
                                style: TextStyle(
                                  fontSize: getProportionScreenWidth(16.0),
                                ),
                              ),
                              SizedBox(height: getProportionScreenHeight(4.0)),
                            ],
                          ),
                        Expanded(
                          child: Text(
                            subtitle,
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: getProportionScreenWidth(16.0),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: getProportionScreenWidth(14.0)),
        ],
      ),
    );
  }
}
