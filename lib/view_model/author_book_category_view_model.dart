import 'package:flutter/cupertino.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/model/author_book_category_repository.dart';
import 'package:tingla/schema/author_book_schema.dart';

class AuthorBookCategoryViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  ApiResponse get response => _apiResponse;

  set setResponse(ApiResponse response) {
    _apiResponse = response;
    notifyListeners();
  }

  /// Call the media service and gets the data of requested media data of
  /// an artist.

  Future<void> getAuthorBookCategory({required String authorId}) async {
    _apiResponse = ApiResponse.loading('Sending requset');
    notifyListeners();

    try {
      List<AuthorBook> response = await AuthorBookCategoryRepository().getAuthorBookCategory(authorId: authorId);
      _apiResponse = ApiResponse.completed(response);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }

    notifyListeners();
  }
}
