import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tingla/api_functions.dart';
import 'package:tingla/screens/profile/components/profile_button.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';

class ImagePickerWidget extends StatelessWidget {
  final Function({dynamic tag}) press;
  const ImagePickerWidget({Key? key, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionScreenWidth(24.0),
            vertical: getProportionScreenHeight(16.0),
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: SizedBox(
                  width: getProportionScreenWidth(60.0),
                  child: const Divider(
                    height: 0,
                    thickness: 2.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                "Rasm yuklash",
                style: TextStyle(
                  fontSize: getProportionScreenWidth(18.0),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: getProportionScreenHeight(32.0),
              ),
              CustomSwitchWidget(
                height: 54.0,
                title: "Galereyadan tanlash",
                leading: 'assets/icons/image_icon.svg',
                press: () async {
                  await press(tag: "gallery");
                  Navigator.pop(context);
                },
                trailing: const SizedBox(),
              ),
              CustomSwitchWidget(
                height: 54.0,
                title: "Rasmga olish",
                leading: 'assets/icons/camera_icon.svg',
                press: () async {
                  await press(tag: "camera");
                  Navigator.pop(context);
                },
                trailing: const SizedBox(),
              ),
              if (Variables.newUserPhoto != null || Variables.userPhoto != null)
                CustomSwitchWidget(
                  height: 54.0,
                  title: "Rasmni o’chirish",
                  leading: 'assets/icons/trash_icon.svg',
                  press: () async {
                    await press(tag: "trash");
                    Navigator.pop(context);
                  },
                  trailing: const SizedBox(),
                ),
            ],
          ),
        ),
      ],
    );
  }

//   Future<void> _deleteProfileImage(context) async {
//     String? _editError;
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return FutureBuilder(
//           future: deleteProfilePhoto(),
//           builder: (context, AsyncSnapshot snapshot) {
//             if (snapshot.hasError) {
//               if (snapshot.error is SocketException) {
//                 _editError =
//                     "Ilitmos internetga ulanib qaytadan urinib ko'ring!";
//               } else {
//                 _editError = snapshot.error.toString();
//               }
//             }

//             if (snapshot.connectionState == ConnectionState.done) {
//               Navigator.pop(context);
//             }

//             return Center(
//               child: Container(
//                 width: getProportionScreenWidth(90.0),
//                 height: getProportionScreenWidth(90.0),
//                 padding: EdgeInsets.all(getProportionScreenWidth(24.0)),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 child: const CircularProgressIndicator(
//                   color: Colors.black,
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );

//     if (_editError != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(_editError.toString()),
//         ),
//       );
//     } else {
//       Navigator.pop(context);
//     }
//   }
}
