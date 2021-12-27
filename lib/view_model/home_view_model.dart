import 'package:flutter/cupertino.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/model/home_repository.dart';
import 'package:tingla/schema/category_schema.dart';

class HomeViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  ApiResponse get response => _apiResponse;

  set setResponse(ApiResponse response) {
    _apiResponse = response;
    notifyListeners();
  }

  /// Call the media service and gets the data of requested media data of
  /// an artist.

  Future<void> getCategories() async {
    _apiResponse = ApiResponse.loading('Sending requset');
    notifyListeners();
    try {
      List<Category> response = await HomeRepository().getCategories();
      _apiResponse = ApiResponse.completed(response);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
