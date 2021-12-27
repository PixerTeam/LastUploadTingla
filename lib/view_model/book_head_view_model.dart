import 'package:flutter/cupertino.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/model/book_head_repository.dart';
import 'package:tingla/model/page_manager.dart';
import 'package:tingla/model/services/service_locator.dart';
import 'package:tingla/database/book_schema_to_database.dart' as localBook;
import 'package:tingla/schema/book_schema.dart' as bookSchema;
import 'package:tingla/schema/head_schema.dart' as networkHeadSchema;
import 'package:tingla/variables/variables.dart';

class BookHeadViewModel with ChangeNotifier {
  bool isDownloaded = true;
  bool isSaved = false;
  final pageManager = getIt<PageManager>();
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  ApiResponse get response => _apiResponse;

  set setResponse(ApiResponse response) {
    _apiResponse = response;
    notifyListeners();
  }

  /// Call the media service and gets the data of requested media data of
  /// an artist.
  Future<void> getNetworkBookHeads({required bookSchema.Book book}) async {
    _apiResponse = ApiResponse.loading('Sending requset');
    await checkIsSaved(id: book.data!.id);

    notifyListeners();

    try {
      List<networkHeadSchema.HeadSchema> newHeads = [];

      for (bookSchema.Head head in book.data!.heads!) {
        networkHeadSchema.HeadSchema response = await BookHeadRepository().getNetworkBookHeads(id: head.headId);
        
        newHeads.add(response);
      }

      try {
        if (pageManager.currentBookId != 'n' + book.data!.id!) {
          pageManager.loadNetworkPlaylist(
            book,
            newHeads,
          );
        }

        await checkIsDownloaded(id: book.data!.id);
      } catch (e) {
        print('Audio Service  Error $e');
      }

      _apiResponse = ApiResponse.completed(newHeads);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }

    notifyListeners();
  }

  Future<void> checkIsDownloaded({required id}) async {
    isDownloaded = await Variables.databaseHelper!.isExist(id, table: 'book');
    notifyListeners();
  }

  Future<void> checkIsSaved({required id}) async {
    isSaved = await Variables.databaseHelper!.isExist(id, table: 'saved');
    notifyListeners();
  }

  Future<void> getLocalBookHeads({required localBook.Book book}) async {
    _apiResponse = ApiResponse.loading('Sending requset');
    await checkIsSaved(id: book.id);
    notifyListeners();

    try {
      List heads = await Variables.databaseHelper!.findQuery(book.id, table: 'head');
      List<localBook.Audio> audios = [];

      for (localBook.Head head in heads) {
        List<dynamic> audio = await Variables.databaseHelper!
            .findQuery(head.headId, table: 'audio');

        if (audio.isNotEmpty) {
          audios.add(audio.first);
        }
      }

      try {
        if (pageManager.currentBookId != 'l' + book.id!) {
          pageManager.loadLocalPlaylist(
            book,
            audios,
            heads,
          );
        }
      } catch (e) {
        print('Audio Service  Error $e');
      }

      _apiResponse = ApiResponse.completed(heads);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }

    notifyListeners();
  }
}
