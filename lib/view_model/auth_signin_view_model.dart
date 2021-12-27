import 'package:flutter/cupertino.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/model/auth_repository.dart';

class AuthSignInViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  ApiResponse get response => _apiResponse;

  set setResponse(ApiResponse response) {
    _apiResponse = response;
    notifyListeners();
  }

  Future<void> checkPhoneNumber(String number) async {
    _apiResponse = ApiResponse.loading("Ma'lumot jo'natilmoqda ...");
    notifyListeners();
    try {
      Map<String, dynamic> response =
          await AuthRepository().checkPhoneNumber(number);

      bool isExist = response['isExist'];

      if (isExist) {
        response = await AuthRepository().signIn(number);
        _apiResponse = ApiResponse.completed(response);
      } else {
        _apiResponse = ApiResponse.completed(isExist);
      }
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
