import 'package:flutter/cupertino.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/model/auth_repository.dart';

class AuthSignUpViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  ApiResponse get response => _apiResponse;

  set setResponse(ApiResponse response) {
    _apiResponse = response;
    notifyListeners();
  }

  /// Call the media service and gets the data of requested media data of
  /// an artist.

  Future<void> signUp(String number, String name) async {
    _apiResponse = ApiResponse.loading('Sending requset');
    notifyListeners();
    try {
      Map<String, dynamic> response =
          await AuthRepository().signUp(number, name);
      _apiResponse = ApiResponse.completed(response);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }

    notifyListeners();
  }
}
