import 'package:flutter/material.dart';
import 'package:tingla/screens/bookmark/bookmark_screen.dart';
import 'package:tingla/screens/home/home_screen.dart';
import 'package:tingla/screens/profile/profile_screen.dart';
import 'package:tingla/screens/search/search_screen.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';
import 'package:tingla/widgets/audio_player_widget.dart';
import 'package:tingla/widgets/custom_bottom_navigation_bar.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({Key? key}) : super(key: key);

  static const List<Widget> _screens = [
    // home screen
    HomeScreen(),
    // search screen
    SearchScreen(),
    // book mark screen
    BookmarkScreen(),
    // profile screen
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            ValueListenableBuilder<int>(
              valueListenable: Variables.currentScreenIndexNotifier,
              builder: (BuildContext context, int index, Widget? child) {
                return _screens[index];
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Column(
                children: const [
                  AudioPlayerWidget(),
                  CustomBottomNavigationBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
