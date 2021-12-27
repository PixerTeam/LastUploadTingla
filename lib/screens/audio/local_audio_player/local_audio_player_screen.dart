import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tingla/database/book_schema_to_database.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/screens/details/connection_error_screen.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/view_model/book_head_view_model.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/custom_button.dart';
import 'package:tingla/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../components/audio_speed_widget.dart';
import 'components/local_audio_body.dart';

class LocalAudioPlayerScreen extends StatelessWidget {
  final Book book;

  const LocalAudioPlayerScreen({Key? key, required this.book})
      : super(key: key);

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
                                .getLocalBookHeads(book: book);
                          },
                        );

                      case Status.INITIAL:
                        Future(() {
                          Provider.of<BookHeadViewModel>(context, listen: false)
                              .getLocalBookHeads(book: book);
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
