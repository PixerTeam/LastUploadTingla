import 'package:flutter/material.dart';
import 'package:tingla/variables/book_control.dart';
import 'package:tingla/variables/book_theme.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/custom_button.dart';

import '../book_read/components/body.dart';
import '../book_read/components/custom_bottom_slider.dart';
import '../book_read/components/read_book_settings_widget.dart';

class ReadBookScreen extends StatefulWidget {
  const ReadBookScreen({Key? key}) : super(key: key);

  @override
  _ReadBookScreenState createState() => _ReadBookScreenState();
}

class _ReadBookScreenState extends State<ReadBookScreen> {
  final BookControl _bookControl = BookControl();

  void callback({size, tag}) {
    if (tag == "dark") {
      if (BookTheme.themeMode) {
        setState(() {
          BookTheme().changeTheme();
        });
      }
    } else if (tag == "light") {
      if (!BookTheme.themeMode) {
        setState(() {
          BookTheme().changeTheme();
        });
      }
    }

    if (size != null) {
      setState(() {
        BookTheme.fontSize = size;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BookTheme.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Body(
              bookControl: _bookControl,
            ),
            CustomAppBar(
              backgroundColor: BookTheme.backgroundColor,
              child: Row(
                children: [
                  CustomButton(
                    press: () {
                      Navigator.pop(context);
                    },
                    icon: 'assets/icons/back_icon.svg',
                    color: BookTheme.textColor,
                  ),
                  const Spacer(),
                  CustomButton(
                    press: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) =>
                            ReadBookSettingsWidget(callback: callback),
                      );
                    },
                    color: BookTheme.textColor,
                    icon: 'assets/icons/settings_icon.svg',
                  ),
                  CustomButton(
                    press: () {},
                    color: BookTheme.textColor,
                    icon: 'assets/icons/share_icon.svg',
                  ),
                ],
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _bookControl.scrolNotifier,
              builder: (_, value, __) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  bottom: value ? 0 : -100.0,
                  child: CustomBottomSlider(
                    bookControl: _bookControl,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
