
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tingla/size_config.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionScreenHeight(24.0),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(.1),
          ),
        ),
      ),
      // color: Colors.red,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: getProportionScreenWidth(40.0),
                height: getProportionScreenHeight(40.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(.1),
                ),
                child: SvgPicture.asset(
                  'assets/icons/person_icon.svg',
                ),
              ),
              SizedBox(width: getProportionScreenWidth(12.0)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Muhammadrizo Alimuhammedov",
                      style: TextStyle(
                        fontSize: getProportionScreenWidth(18.0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      "15/02/2021",
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
            height: getProportionScreenHeight(19.0),
          ),
          Text(
            "Ilova ajoyib tarzda ishlangan, dizayniga gap yo’q, kitobni o’qigan insonlarga rahmat",
            style: TextStyle(
              fontSize: getProportionScreenWidth(18.0),
              fontWeight: FontWeight.bold,
              height: getProportionScreenHeight(2.6),
            ),
          ),
        ],
      ),
    );
  }
}
