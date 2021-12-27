import 'package:flutter/cupertino.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/model/subcriptions_repository.dart';
import 'package:tingla/schema/subcription_schema.dart';

class SubcriptionViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  ApiResponse get response => _apiResponse;

  set setResponse(ApiResponse response) {
    _apiResponse = response;
    notifyListeners();
  }

  Future<void> getSubcriptions() async {
    _apiResponse = ApiResponse.loading('Sending requset');
    notifyListeners();
    try {
      List<Subcription> response =
          await SubcriptionsRepository().getSubcriptions();
      _apiResponse = ApiResponse.completed(response);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
