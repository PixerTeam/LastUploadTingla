import 'dart:io' as io;
import 'package:flutter/services.dart' ;
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/model/page_manager.dart';
import 'package:tingla/model/services/service_locator.dart';
import 'package:tingla/schema/profile_data_schema.dart';
import 'package:tingla/screens/app/app_screen.dart';
import 'package:tingla/screens/splash/splash_screen.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';
import 'package:provider/provider.dart';
import 'package:tingla/view_model/home_view_model.dart';

import 'database/database_helper.dart';
import 'screens/splash/introduction_screen.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  io.HttpOverrides.global = MyHttpOverrides();

  await setupServiceLocator();

  await SentryFlutter.init(
    (options) => options.dsn =
        'https://e1efba9a85744a8fb990d07f0d5f409d@o1095190.ingest.sentry.io/6114183',
    appRunner: () => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: HomeViewModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tingla',
          theme: ThemeData(
            primaryColor: Colors.black,
            scaffoldBackgroundColor: kBackgroundColor,
          ),
          home: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getIt<PageManager>().init();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Variables.databaseHelper = DatabaseHelper.instance;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Theme(
      data: theme(),
      child: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Variables.prefs = snapshot.data;
            // Variables.prefs!.setString('token', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFiNzg0ODE5LTQ2OTUtNDJmOS04ZThkLWFiZDRiYzUxNDhlNSIsImlhdCI6MTY0MDE3NzYwN30.hOiLja38tW73kQoqyKIqBQAHWysN3fAtueb3jn-opKs');
            Variables.userToken = Variables.prefs!.getString('token');

            if (Variables.userToken != null) {
              return FutureBuilder(
                future:
                    Variables.databaseHelper!.queryAllRows(table: "profile"),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length != 0) {
                      Variables.profileData =
                          LocalProfileData.fromJson(snapshot.data[0]);
                    }
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    return const SplashScreen(child: AppScreen());
                  }

                  return const SplashScreen();
                },
              );
            } else {
              return const SplashScreen(child: IntroductionScreen());
            }
          }
          return const SplashScreen();
        },
      ),
    );
  }
}

class MyHttpOverrides extends io.HttpOverrides {
  @override
  io.HttpClient createHttpClient(io.SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (io.X509Certificate cert, String host, int port) => true;
  }
}
