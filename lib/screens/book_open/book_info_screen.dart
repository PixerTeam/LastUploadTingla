import 'package:flutter/material.dart';
import 'package:tingla/api_functions.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/screens/details/connection_error_screen.dart';
import 'package:tingla/variables/variables.dart';
import 'package:tingla/view_model/network_book_view_model.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/custom_button.dart';
import 'package:tingla/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import 'book_loading_screen.dart';
import 'components/body.dart';

class BookInfoScreen extends StatefulWidget {
  final String id;
  final dynamic data;
  const BookInfoScreen({Key? key, required this.id, this.data})
      : super(key: key);

  @override
  _BookInfoScreenState createState() => _BookInfoScreenState();
}

class _BookInfoScreenState extends State<BookInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ChangeNotifierProvider(
              create: (context) => NetworkBookViewModel(),
              builder: (context, __) {
                ApiResponse apiResponse = Provider.of<NetworkBookViewModel>(context).response;
                
                bool _isSaved = Provider.of<NetworkBookViewModel>(context).isSaved;
                bool _isDownloaded = Provider.of<NetworkBookViewModel>(context).isDownloaded;
                bool _isSubcription = Provider.of<NetworkBookViewModel>(context).isSubcriptioned;

                return Stack(
                  children: [
                    Builder(builder: (context) {
                      switch (apiResponse.status) {
                        case Status.LOADING:
                          return BookLoadingScreen(
                            data: widget.data,
                          );

                        case Status.COMPLETED:
                          Variables.openBook = apiResponse.data;

                          return const Body();

                        case Status.ERROR:
                          return ConnectionErrorScreen(
                            press: () async {
                              Provider.of<NetworkBookViewModel>(context,
                                      listen: false)
                                  .getNetworkBook(id: widget.id);
                            },
                          );

                        case Status.INITIAL:
                          Future(() => Provider.of<NetworkBookViewModel>(
                                  context,
                                  listen: false)
                              .getNetworkBook(id: widget.id));
                          return const LoadingWidget();
                      }
                    }),
                    CustomAppBar(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomButton(
                            icon: 'assets/icons/back_icon.svg',
                            press: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Spacer(),
                          if (!_isDownloaded && _isSubcription)
                            CustomButton(
                              icon: 'assets/icons/download_icon.svg',
                              press: () async {
                                if (Variables.downloadNotifier.value ==
                                        DownloadState.notDonwloaded ||
                                    Variables.downloadNotifier.value ==
                                        DownloadState.errorDownloading ||
                                    Variables.downloadNotifier.value ==
                                        DownloadState.downloaded) {
                                  
                                  int _value = await downloadBook(apiResponse.data);

                                  if (_value != 0) {
                                    Provider.of<NetworkBookViewModel>(context,
                                            listen: false)
                                        .checkIsDownloaded(id: widget.id);
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Kitob yuklanmoqda kutib turing!'),
                                    ),
                                  );
                                }
                              },
                            ),
                          CustomButton(
                            color: Colors.black,
                            icon: _isSaved
                                ? 'assets/icons/bookmark_fill_icon.svg'
                                : 'assets/icons/bookmark_black_icon.svg',
                            press: () async {
                              if (!_isSaved) {
                                await Variables.databaseHelper!.insert(widget.data, table: 'saved');
                              } else {
                                await Variables.databaseHelper!.delete(widget.id, table: 'saved');
                              }

                              Provider.of<NetworkBookViewModel>(context,
                                      listen: false)
                                  .checkIsSaved(id: widget.id);
                            },
                          ),
                          CustomButton(
                            icon: 'assets/icons/share_icon.svg',
                            press: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
