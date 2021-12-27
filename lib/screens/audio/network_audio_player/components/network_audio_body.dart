import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tingla/api_functions.dart';
import 'package:tingla/model/page_manager.dart';
import 'package:tingla/model/services/service_locator.dart';
import 'package:tingla/schema/book_schema.dart';
import 'package:tingla/schema/head_schema.dart' as headSchema;
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';
import 'package:tingla/view_model/book_head_view_model.dart';
import 'package:tingla/widgets/book_image_widget.dart';
import 'package:tingla/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../components/audio_bottom_buttons.dart';
import '../../components/audio_list_widget.dart';
import '../../components/audio_progress_bar.dart';

class Body extends StatelessWidget {
  final Book book;
  final List<headSchema.HeadSchema> heads;
  const Body({Key? key, required this.book, required this.heads})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isDownloaded = Provider.of<BookHeadViewModel>(context).isDownloaded;
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
            imageUrl: book.data!.bookPhoto,
            star: book.rating,
            title: book.data!.title,
            author: book.data!.author!.authorName,
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
            },
          ),
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
                        title: book.data!.title!,
                      ),
                    );
                  },
                  color: Colors.black,
                  size: 26.0,
                ),
                CustomButton(
                  icon: _isDownloaded
                      ? 'assets/icons/audio_download_icon.svg'
                      : 'assets/icons/download_icon.svg',
                  press: () async {
                    if (!_isDownloaded) {
                      if (Variables.downloadNotifier.value ==
                              DownloadState.notDonwloaded ||
                          Variables.downloadNotifier.value ==
                              DownloadState.errorDownloading ||
                          Variables.downloadNotifier.value ==
                              DownloadState.downloaded) {
                        bool isDownloaded = await Variables.databaseHelper!
                            .isExist(book.data!.id!, table: 'book');

                        if (isDownloaded) {
                          Provider.of<BookHeadViewModel>(context, listen: false)
                              .checkIsDownloaded(id: book.data!.id);
                        } else {
                          int _value = await downloadBook(book);

                          if (_value != 0) {
                            Provider.of<BookHeadViewModel>(context,
                                    listen: false)
                                .checkIsDownloaded(id: book.data!.id);
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Kitob yuklanmoqda kutib turing!'),
                          ),
                        );
                      }
                    }
                  },
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
