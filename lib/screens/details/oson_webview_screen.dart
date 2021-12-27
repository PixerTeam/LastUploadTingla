import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/variables/variables.dart';
import 'package:tingla/view_model/payment_view_model.dart';
import 'package:tingla/widgets/loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';

class OsonWebviewScreen extends StatefulWidget {
  final String id;
  const OsonWebviewScreen({Key? key, required this.id}) : super(key: key);

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<OsonWebviewScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
            create: (context) => PaymentViewModel(),
            builder: (context, value) {
              ApiResponse apiResponse =
                  Provider.of<PaymentViewModel>(context).response;
              switch (apiResponse.status) {
                case Status.LOADING:
                  return const LoadingWidget();
                case Status.COMPLETED:
                  return WebView(
                    initialUrl: apiResponse.data['data']['payment_url'],
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageStarted: (String url) {
                      if (url == 'https://tingla.pixer.uz/') {
                        Variables.isSubcriptioned = true;

                        Navigator.pop(context);
                      }
                    },
                    gestureNavigationEnabled: true,
                    backgroundColor: const Color(0x00000000),
                  );
                case Status.ERROR:
                  Future(
                    () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(apiResponse.message.toString()),
                      ),
                    ),
                  );

                  Navigator.pop(context);
                  return Container();

                case Status.INITIAL:
                  Future(
                    () => Provider.of<PaymentViewModel>(context, listen: false)
                        .createPaymentOson(id: widget.id),
                  );
                  return const LoadingWidget();
              }
            }),
      ),
    );
  }
}
