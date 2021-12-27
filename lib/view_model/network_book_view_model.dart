import 'package:flutter/cupertino.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/model/network_book_repository.dart';
import 'package:tingla/schema/book_schema.dart';
import 'package:tingla/variables/variables.dart';

class NetworkBookViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  bool isDownloaded = true;
  bool isSaved = false;
  bool isSubcriptioned = false;

  ApiResponse get response => _apiResponse;

  set setResponse(ApiResponse response) {
    _apiResponse = response;
    notifyListeners();
  }

  /// Call the media service and gets the data of requested media data of
  /// an artist.
  Future<void> getNetworkBook({required id}) async {
    await checkIsSaved(id: id);

    _apiResponse = ApiResponse.loading('Sending requset');
    notifyListeners();

    try {
      Book response = await NetworkBookRepository().getNetworkBook(id: id);
      _apiResponse = ApiResponse.completed(response);

      checkIsSubcriptioned();
      await checkIsDownloaded(id: id);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> checkIsDownloaded({required id}) async {
    isDownloaded = await Variables.databaseHelper!.isExist(id, table: 'book');
    notifyListeners();
  }

  Future<void> checkIsSaved({required id}) async {
    isSaved = await Variables.databaseHelper!.isExist(id, table: 'saved');
    notifyListeners();
  }

  void checkIsSubcriptioned() async {
    if (_apiResponse.data.isSubscribed ?? false) {
      isSubcriptioned = true;
    } else {
      isSubcriptioned = false;
    }

    notifyListeners();
  }
}
