import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tingla/database/book_schema_to_database.dart';
import 'package:tingla/model/page_manager.dart';
import 'package:tingla/model/services/service_locator.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/widgets/book_image_widget.dart';
import 'package:tingla/widgets/custom_button.dart';

import '../../components/audio_bottom_buttons.dart';
import '../../components/audio_list_widget.dart';
import '../../components/audio_progress_bar.dart';

class Body extends StatelessWidget {
  final Book book;
  final List heads;
  const Body({Key? key, required this.book, required this.heads})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: getProportionScreenHeight(34.0),
        horizontal: getProportionScreenWidth(38.0),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 70.0,
          ),
          BookImageWidget(
            imageUrl: book.bookPhoto,
            star: book.rating,
            title: book.title,
            author: book.authorName,
          ),
          SizedBox(
            height: getProportionScreenHeight(8.0),
          ),
          ValueListenableBuilder<MediaItem?>(
              valueListenable: pageManager.currentSongNotifier,
              builder: (__, MediaItem? item, _) {
                if (item != null) {
                  return Column(
                    children: [
                      SizedBox(
                        height: getProportionScreenHeight(16.0),
                      ),
                      Text(
                        '${item.id}-bob',
                        style: TextStyle(
                          color: const Color(0xFFFCBD2C),
                          fontSize: getProportionScreenWidth(18.0),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: getProportionScreenHeight(16.0),
                      ),
                      Text(
                        '1-bob',
                        style: TextStyle(
                          color: const Color(0xFFFCBD2C),
                          fontSize: getProportionScreenWidth(18.0),
                        ),
                      ),
                    ],
                  );
                }
              }),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionScreenWidth(9.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  icon: CupertinoIcons.list_bullet,
                  press: () {
                    showModalBottomSheet(
                      enableDrag: false,
                      isScrollControlled: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => AudioListWidget(
                        title: book.title!,
                      ),
                    );
                  },
                  color: Colors.black,
                  size: 26.0,
                ),
                CustomButton(
                  icon: 'assets/icons/audio_download_icon.svg',
                  press: () async {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: getProportionScreenHeight(24.0),
          ),
          const AudioProgressBar(),
          SizedBox(
            height: getProportionScreenHeight(21.0),
          ),
          const AudioBottomButtons(),
        ],
      ),
    );
  }
}
