import 'package:flutter/material.dart';
import 'package:tingla/constants.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/screens/auth/verify_screen.dart';
import 'package:tingla/screens/details/loading_screen.dart';
import 'package:tingla/size_config.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:tingla/view_model/auth_signin_view_model.dart';
import 'package:tingla/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

import 'input_name_screen.dart';

class CheckPhoneNumberScreen extends StatefulWidget {
  const CheckPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  _CheckPhoneNumberScreenState createState() => _CheckPhoneNumberScreenState();
}

class _CheckPhoneNumberScreenState extends State<CheckPhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  String _phone = "";
  bool _isTapped = false;

  bool _phoneValidate = true;
  String _phoneValidateText = "";

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    PhoneInputFormatter.replacePhoneMask(
      countryCode: 'UZ',
      newMask: '+000 00 000-00-00',
    );

    _textEditingController.addListener(() {
      if (_textEditingController.text.length < 4) {
        _textEditingController.text = '+998';

        _textEditingController.selection =
            const TextSelection(baseOffset: 4, extentOffset: 4);
      }
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ChangeNotifierProvider<AuthSignInViewModel>(
            create: (context) => AuthSignInViewModel(),
            builder: (context, value) {
              ApiResponse apiResponse =
                  Provider.of<AuthSignInViewModel>(context).response;

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
                              controller: _textEditingController,
                              cursorWidth: getProportionScreenWidth(1.0),
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                PhoneInputFormatter(),
                              ],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.1,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromRGBO(247, 247, 247, 1),
                                hintText: "Telefon raqamingiz",
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
                                if (_phoneValidate) {
                                  return null;
                                }

                                return _phoneValidateText;
                              },
                              onChanged: (text) {
                                setState(() {
                                  _phoneValidate = true;
                                });
                              },
                              onSaved: (text) {
                                _phone = text!;
                              },
                              onTap: () {
                                if (!_isTapped) {
                                  _textEditingController.text = '+998';
                                  _isTapped = true;
                                }
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
                              Provider.of<AuthSignInViewModel>(context,
                                      listen: false)
                                  .checkPhoneNumber(_splitFormatter(_phone));
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  _getLoadingWidget(context, apiResponse),
                ],
              );
            }),
      ),
    );
  }

  Widget _getLoadingWidget(context, ApiResponse apiResponse) {
    switch (apiResponse.status) {
      case Status.LOADING:
        return const LoadingScreen();
      case Status.COMPLETED:
        
        String _phoneNumber = _splitFormatter(_phone);
        try {
          if (apiResponse.data is Map) {
            Future(() =>
                Provider.of<AuthSignInViewModel>(context, listen: false)
                    .setResponse = ApiResponse.initial('initial'));

            String? data = apiResponse.data['data'];

            
            if (data != null) {
              Future(() => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistorVerifySms(
                        phone: _phoneNumber,
                        data: data,
                      ),
                    ),
                  ));
            }
          } else {
            Future(() =>
                Provider.of<AuthSignInViewModel>(context, listen: false)
                    .setResponse = ApiResponse.initial('initial'));
            Future(() => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InputNameScreen(
                      phoneNumber: _phoneNumber,
                    ),
                  ),
                ));
          }
        } catch (exception) {
          if (exception == "type 'Null' is not a subtype of type 'bool'") {
            Future(() =>
                Provider.of<AuthSignInViewModel>(context, listen: false)
                    .setResponse = ApiResponse.initial('initial'));

            Future(() => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistorVerifySms(
                      phone: _phoneNumber,
                      data: apiResponse.data['data'],
                    ),
                  ),
                ));
          }
        }

        break;
      case Status.ERROR:
        Future(() => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(apiResponse.message.toString()),
              ),
            ));

        Future(() => Provider.of<AuthSignInViewModel>(context, listen: false)
            .setResponse = ApiResponse.initial('initial'));
        break;
      case Status.INITIAL:
        break;
    }
    return const SizedBox();
  }

  String _splitFormatter(String number) {
    String _code =
        number.split('+')[1].split(' ')[0] + number.split('+')[1].split(' ')[1];
    String _number = number.split('+')[1].split(' ')[2].split('-')[0] +
        number.split('+')[1].split(' ')[2].split('-')[1] +
        number.split('+')[1].split(' ')[2].split('-')[2];
    String _phoneNumber = _code.toString() + _number.toString();

    return _phoneNumber;
  }

  void _checkValidate() {
    _formKey.currentState!.save();

    _phoneValidate = true;

    if (_phone.isEmpty) {
      _phoneValidate = false;
      _phoneValidateText = "Iltimos raqamingizni kiriting!";
    } else if (_phone.length < 17) {
      _phoneValidate = false;
      _phoneValidateText = "Iltimos raqamingizni to'liq kiriting!";
    }
  }
}
