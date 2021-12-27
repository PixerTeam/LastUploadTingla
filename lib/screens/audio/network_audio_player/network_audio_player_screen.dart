import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/schema/book_schema.dart';
import 'package:tingla/screens/details/connection_error_screen.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';
import 'package:tingla/view_model/book_head_view_model.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/custom_button.dart';
import 'package:tingla/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../components/audio_speed_widget.dart';
import 'components/network_audio_body.dart';

class AudioPlayerScreen extends StatelessWidget {
  final Book book;

  const AudioPlayerScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => BookHeadViewModel()),
          ],
          builder: (context, value) {
            bool _isSaved = Provider.of<BookHeadViewModel>(context).isSaved;

            return Stack(
              children: [
                Builder(
                  builder: (context) {
                    ApiResponse _bookHeadsResponse =
                        Provider.of<BookHeadViewModel>(context).response;

                    switch (_bookHeadsResponse.status) {
                      case Status.COMPLETED:
                        return Body(
                          book: book,
                          heads: Provider.of<BookHeadViewModel>(context)
                              .response
                              .data,
                        );

                      case Status.ERROR:
                        return ConnectionErrorScreen(
                          press: () {
                            Provider.of<BookHeadViewModel>(context,
                                    listen: false)
                                .getNetworkBookHeads(book: book);
                          },
                        );

                      case Status.INITIAL:
                        Future(() {
                          Provider.of<BookHeadViewModel>(context, listen: false)
                              .getNetworkBookHeads(book: book);
                        });
                        
                        return const LoadingWidget();

                      case Status.LOADING:
                        return const LoadingWidget();
                    }
                  },
                ),
                CustomAppBar(
                  child: Row(
                    children: [
                      CustomButton(
                        press: () {
                          Navigator.pop(context);
                        },
                        icon: 'assets/icons/back_icon.svg',
                        color: Colors.black,
                      ),
                      const Spacer(),
                      const AudioSpeedWidget(),
                      SizedBox(
                        width: getProportionScreenWidth(8.0),
                      ),
                      CustomButton(
                        color: Colors.black,
                        icon: _isSaved
                            ? 'assets/icons/bookmark_fill_icon.svg'
                            : 'assets/icons/bookmark_black_icon.svg',
                        press: () async {
                          if (!_isSaved) {
                            await Variables.databaseHelper!
                                .insert(book.data, table: 'saved');
                          } else {
                            await Variables.databaseHelper!
                                .delete(book.data!.id, table: 'saved');
                          }

                          Provider.of<BookHeadViewModel>(context, listen: false).checkIsSaved(id: book.data!.id);
                        },
                      ),
                      CustomButton(
                        press: () {},
                        color: Colors.black,
                        icon: 'assets/icons/share_icon.svg',
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
