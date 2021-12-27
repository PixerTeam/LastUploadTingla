import 'package:flutter/material.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/screens/details/loading_screen.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/view_model/auth_signup_view_model.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

import 'verify_screen.dart';

class InputNameScreen extends StatefulWidget {
  final String phoneNumber;
  const InputNameScreen({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  _InputNameScreenState createState() => _InputNameScreenState();
}

class _InputNameScreenState extends State<InputNameScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";

  bool _nameValidate = true;
  String _nameValidateText = "";

  Widget _getLoadingWidget(context, ApiResponse apiResponse) {
    

    switch (apiResponse.status) {
      case Status.LOADING:
        return const LoadingScreen();
      case Status.COMPLETED:
        

        Future(() => Provider.of<AuthSignUpViewModel>(context, listen: false)
            .setResponse = ApiResponse.initial('initial'));

        Future(() => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegistorVerifySms(
                  phone: widget.phoneNumber,
                  data: apiResponse.data['data']['id'],
                ),
              ),
            ));

        break;
      case Status.ERROR:
        Future(() => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(apiResponse.message.toString()),
              ),
            ));

        Future(() => Provider.of<AuthSignUpViewModel>(context, listen: false)
            .setResponse = ApiResponse.initial('initial'));
        break;
      case Status.INITIAL:
        break;
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ChangeNotifierProvider<AuthSignUpViewModel>(
          create: (context) => AuthSignUpViewModel(),
          builder: (context, value) {
            ApiResponse _apiResponse =
                Provider.of<AuthSignUpViewModel>(context).response;

            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionScreenWidth(24.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: getProportionScreenHeight(160.0)),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: SingleChildScrollView(
                          child: TextFormField(
                            cursorWidth: getProportionScreenWidth(1.0),
                            keyboardType: TextInputType.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.1,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromRGBO(247, 247, 247, 1),
                              hintText: "Ismingiz",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.1,
                                fontSize: getProportionScreenWidth(20.0),
                                color: kTextColor.withOpacity(.4),
                              ),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              counterText: "",
                            ),
                            validator: (text) {
                              if (_nameValidate) {
                                return null;
                              }

                              return _nameValidateText;
                            },
                            onSaved: (text) {
                              _name = text!;
                            },
                            onChanged: (text) {
                              setState(() {
                                _nameValidate = true;
                              });
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                CustomAppBar(
                  child: Text(
                    "Ro'yxatdan o'tish",
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: getProportionScreenWidth(28.0),
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.1,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionScreenHeight(40.0),
                      horizontal: getProportionScreenWidth(24.0),
                    ),
                    child: SizedBox(
                      height: getProportionScreenHeight(60.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          primary: const Color.fromRGBO(15, 15, 84, 1),
                        ),
                        child: Text(
                          "Ro'yxatdan o'tish",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: getProportionScreenWidth(20.0),
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.1,
                          ),
                        ),
                        onPressed: () {
                          _checkValidate();

                          if (_formKey.currentState!.validate()) {
                            Provider.of<AuthSignUpViewModel>(context,
                                    listen: false)
                                .signUp(widget.phoneNumber, _name);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                _getLoadingWidget(context, _apiResponse),
              ],
            );
          },
        ),
      ),
    );
  }

  _checkValidate() {
    _formKey.currentState!.save();

    _nameValidate = true;
    if (_name.isEmpty) {
      _nameValidate = false;
      _nameValidateText = "Iltimos ismingizni kiriting!";
    } else if (_name.length < 3) {
      _nameValidate = false;
      _nameValidateText = "Iltimos ismingizni to'liq kiriting!";
    }
  }
}
