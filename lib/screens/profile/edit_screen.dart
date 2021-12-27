import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tingla/api_functions.dart';
import 'package:tingla/screens/details/loading_screen.dart';
import 'package:tingla/screens/profile/components/profile_button.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:tingla/widgets/custom_button.dart';

import 'components/bottom_image_picker_widget.dart';
import 'components/change_name_widget.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  void initState() {
    Variables.userPhoto = Variables.profileData!.userPhoto;

    super.initState();
  }

  Future getImage({tag}) async {
    XFile? _pickedFile;

    if (tag == "trash") {
      Variables.newUserPhoto = null;
      Variables.userPhoto = null;
    } else if (tag == "gallery") {
      _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    } else if (tag == "camera") {
      _pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    }

    if (_pickedFile != null) {
      Variables.newUserPhoto = File(_pickedFile.path);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget _imageWidget = Container(
      height: getProportionScreenWidth(140.0),
      width: getProportionScreenWidth(140.0),
      padding: EdgeInsets.all(getProportionScreenWidth(38.0)),
      decoration: const BoxDecoration(
        color: Color(0xFFE5E5E5),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        "assets/icons/user_icon.svg",
        color: Colors.black.withOpacity(.8),
      ),
    );

    if (Variables.userPhoto != null) {
      _imageWidget = CachedNetworkImage(
        imageUrl: Variables.userPhoto ?? '',
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
          height: getProportionScreenWidth(140.0),
          width: getProportionScreenWidth(140.0),
        ),
        errorWidget: (context, error, imageProvider) => Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          height: getProportionScreenHeight(140.0),
          width: getProportionScreenWidth(140.0),
        ),
        placeholder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          height: getProportionScreenHeight(140.0),
          width: getProportionScreenWidth(140.0),
        ),
      );
    }

    if (Variables.newUserPhoto != null) {
      _imageWidget = Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: FileImage(Variables.newUserPhoto!),
            fit: BoxFit.cover,
          ),
        ),
        height: getProportionScreenWidth(140.0),
        width: getProportionScreenWidth(140.0),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: getProportionScreenWidth(24.0),
                right: getProportionScreenWidth(24.0),
                bottom: getProportionScreenHeight(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 100.0,
                  ),
                  Center(
                    child: SizedBox(
                      height: getProportionScreenWidth(140.0),
                      width: getProportionScreenWidth(140.0),
                      child: Stack(
                        children: [
                          _imageWidget,
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) =>
                                      ImagePickerWidget(press: getImage),
                                );
                              },
                              child: Container(
                                height: getProportionScreenWidth(50.0),
                                width: getProportionScreenWidth(50.0),
                                padding: EdgeInsets.all(
                                    getProportionScreenWidth(13.0)),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.8),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  'assets/icons/camera_icon.svg',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionScreenHeight(20.0),
                  ),
                  Center(
                    child: Text(
                      "Set profile photo",
                      style: TextStyle(
                        fontSize: getProportionScreenWidth(18.0),
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionScreenHeight(60.0),
                  ),
                  CustomSwitchWidget(
                    leading: 'assets/icons/person_icon.svg',
                    trailing: SvgPicture.asset(
                      'assets/icons/pencil_icon.svg',
                      color: Colors.black,
                    ),
                    title:
                        Variables.newUserName ?? Variables.profileData!.name!,
                    subtitle: "Ismingiz",
                    press: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => ChangeNameWidget(),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                  ),
                  Divider(
                    thickness: 0.8,
                    color: Colors.grey.shade400,
                  ),
                  CustomSwitchWidget(
                    leading: 'assets/icons/phone_icon.svg',
                    trailing: Container(),
                    title:
                        "+${Variables.newUserPhone ?? Variables.profileData!.phone}",
                    subtitle: "Telefon raqamingiz",
                    press: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ChangeNumberWidget(),
                      //   ),
                      // ).then((value) {
                      //   setState(() {});
                      // });
                    },
                  ),
                  Divider(
                    thickness: 0.8,
                    color: Colors.grey.shade400,
                  ),
                  const Spacer(),
                  SizedBox(
                    height: getProportionScreenHeight(60.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF0F0F54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: _saveData,
                      child: Text(
                        "Saqlash",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: getProportionScreenWidth(20.0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomAppBar(
              child: Row(
                children: [
                  CustomButton(
                    icon: 'assets/icons/back_icon.svg',
                    color: Colors.black,
                    press: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: getProportionScreenWidth(12.0)),
                  Expanded(
                    child: Text(
                      "Mening profilim",
                      style: TextStyle(
                        fontSize: getProportionScreenWidth(24.0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveData() {
    String? _editError;
    if (Variables.newUserName != null ||
        Variables.newUserPhoto != null ||
        (Variables.userPhoto == null &&
            Variables.profileData!.userPhoto != null)) {
      showDialog(
        context: context,
        builder: (context) {
          return FutureBuilder(
            future: editPersonlaData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                if (snapshot.error is SocketException) {
                  _editError =
                      "Ilitmos internetga ulanib qaytadan urinib ko'ring!";
                } else {
                  _editError = snapshot.error.toString();
                }
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Navigator.pop(context);
              }

              return const LoadingScreen();
            },
          );
        },
      ).then((value) {
        if (_editError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_editError.toString()),
            ),
          );
        } else {
          Navigator.pop(context);
        }
      });
    } else {
      Navigator.pop(context);
    }
  }
}
