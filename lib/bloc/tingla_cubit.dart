import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tingla/api_functions.dart';
import 'package:tingla/variables/variables.dart';

import 'package:tingla/schema/author_book_schema.dart' as authorBook;
import 'package:tingla/schema/cache_book_schema.dart' as cacheBook;
import 'package:tingla/schema/book_schema.dart' as bookSchema;
import 'package:tingla/schema/head_schema.dart' as headSchema;
import 'package:tingla/schema/one_category_schema.dart' as oneCategory;
import 'package:tingla/database/book_schema_to_database.dart' as localBookSchema;

import 'tingla_state.dart';

class TinglaCubit extends Cubit<TinglaState> {
  TinglaCubit(TinglaState initialState) : super(initialState);

  // ---------------------------------------------------- WORK NETWORK DATA ---------------------------------->

  // for get all categories in network
  Future<void> getCategories() async {
    try {
      emit(const TinglaLoading());
      Variables.categories = await getCategoriesData();
      emit(const TinglaCompleted());
    } catch (e) {
      emit(TinglaError("HOME SCREEN ERROR: $e"));
    }
  }

  // for get one category in network
  Future<void> getOneCategory(categoryId) async {
    try {
      emit(const TinglaLoading());
      oneCategory.OneCategory response = await getOneCategoryData(categoryId);
      emit(TinglaCompleted(
        response: response,
      ));
    } catch (e) {
      emit(TinglaError("COLLECTION SCREEN ERROR: $e"));
    }
  }

  // for get one category in network
  Future<void> getAuthorCategory(authorId) async {
    try {
      emit(const TinglaLoading());
      List<authorBook.AuthorBook> response = await getAuthorCategoryData(authorId);
      emit(TinglaCompleted(
        response: response,
      ));
    } catch (e) {
      emit(TinglaError("Author collection SCREEN ERROR: $e"));
    }
  }

  // For get one book in network
  Future<void> getOneBook(bookId) async {
    try {
      emit(const TinglaLoading());
      Variables.openBook = await getOneBookData(bookId);
      emit(const TinglaCompleted());
    } catch (e) {
      emit(TinglaError("OPEN BOOK SCREEN ERROR: $e"));
    }
  }

  // For get profile data in network
  Future<void> getProfile() async {
    emit(const TinglaLoading());
    try {
      Variables.profileData = await getProfileData();
      emit(const TinglaCompleted());
    } catch (e) {
      emit(TinglaError("PROFILE SCREEN DATA ERROR $e"));
    }
  }

  // For get one head in network
  Future<void> getHead(headId) async {
    emit(const TinglaLoading());
    try {
      headSchema.HeadSchema? head = await getOneHeadData(headId);
      emit(TinglaCompleted(response: head));
    } catch (e) {
      emit(TinglaError("HEAD DATA ERROR: " + e.toString()));
    }
  }

  // For get top books in network
  Future<void> getBestBooks() async {
    try {
      emit(const TinglaLoading());
      Variables.bestBooks = await getBestBooksData();
      emit(const TinglaCompleted());
    } catch (e) {
      emit(TinglaError("GET BEST BOOKS DATA ERROR: " + e.toString()));
    }
  }

  // For get one heads in network
  Future<void> getHeadsInNetwork(bookSchema.Book book) async {
    emit(const TinglaLoading());
    try {
      List<headSchema.HeadSchema> _heads = [];
      for (bookSchema.Head head in book.data!.heads!) {
        headSchema.HeadSchema? newHead = await getOneHeadData(head.headId);

        _heads.add(newHead);
      }

      Variables.bookHeads = {
        "book_id": book.data!.id,
        "heads": _heads,
      };

      emit(TinglaCompleted(response: _heads));
    } catch (e) {
      emit(TinglaError("HEAD DATA ERROR: " + e.toString()));
    }
  }

  // --------------------------------- WORK DATABASE DATA --------------------------------------->

  // For get history words in database
  Future<void> getSearchHistory() async {
    try {
      emit(const TinglaLoading());
      List<Map<String, dynamic>> data =
          await Variables.databaseHelper!.queryAllRows(table: 'history');

      List<String> _history = [];
      for (var text in data) {
        _history.add(text['item']);
      }

      emit(TinglaCompleted(response: _history));
    } catch (e) {
      emit(TinglaError("GET BEST BOOKS DATA ERROR: " + e.toString()));
    }
  }

  // For get one data cache book in database
  void getCacheBook(bookId) async {
    try {
      emit(const TinglaLoading());
      var data =
          await Variables.databaseHelper!.findQuery(bookId, table: 'cache');

      if (data.isNotEmpty) {
        emit(TinglaCompleted(response: data[0]));
      } else {
        emit(const TinglaError("GET CACHE BOOK DATA IS EMPTY"));
      }
    } catch (e) {
      emit(TinglaError("GET CACHE BOOK DATA ERROR: " + e.toString()));
    }
  }

  // for get saved books data in database
  Future<void> getSavedBooks() async {
    try {
      emit(const TinglaLoading());
      List<Map<String, dynamic>> data =
          await Variables.databaseHelper!.queryAllRows(table: 'saved');

      List<bookSchema.SavedBook> savedbooks = [];

      for (Map<String, dynamic> element in data) {
        savedbooks.add(bookSchema.SavedBook.fromDatabase(element));
      }

      Variables.savedBooks = savedbooks;
      emit(const TinglaCompleted());
    } catch (e) {
      emit(TinglaError("SAVED SCREEN ERROR: $e"));
    }
  }

  // For get heads in database
  Future<void> getBookHeads(String bookId) async {
    try {
      emit(const TinglaLoading());
      List data = await Variables.databaseHelper!
          .queryAllRows(table: 'head', id: bookId);

      List<localBookSchema.Head> _heads = [];

      for (var head in data) {
        _heads.add(localBookSchema.Head.fromJson(head));
      }

      Variables.localBookHeads = {
        "book_id": bookId,
        "heads": _heads,
      };

      emit(TinglaCompleted(response: _heads));
    } catch (e) {
      emit(TinglaError("GET LOCAL HEADS DATA ERROR: " + e.toString()));
    }
  }

  // For get audio in database
  Future<void> getHeadAudio(headId) async {
    try {
      emit(TinglaLoading());
      List data = await Variables.databaseHelper!
          .queryAllRows(table: 'audio', id: headId);

      List<localBookSchema.Audio> _audio = [];
      data.forEach(
          (audio) => _audio.add(localBookSchema.Audio.fromDatabase(audio)));

      emit(TinglaCompleted(response: _audio));
    } catch (e) {
      emit(TinglaError("GET LOCAL AUDIO DATA ERROR: " + e.toString()));
    }
  }

  // For get audios in database
  // Future<void> getBookAudios(List<localBookSchema.Book> book) async {
  //   try {
  //     emit(TinglaLoading());

  //     List<localBookSchema.Audio> _audios = [];

  //     for (localBookSchema.Head head in book.) {
  //       List data = await Variables.databaseHelper!
  //           .queryAllRows(table: 'audio', id: head.headId);

  //       data.forEach(
  //           (audio) => _audios.add(localBookSchema.Audio.fromDatabase(audio)));
  //     }

  //     emit(TinglaCompleted(response: _audios));
  //   } catch (e) {
  //     emit(TinglaError("GET LOCAL AUDIOS DATA ERROR: " + e.toString()));
  //   }
  // }

  // for get all data cache local books in database
  Future<void> getReadBooks() async {
    try {
      emit(TinglaLoading());
      List<Map<String, dynamic>> _data =
          await Variables.databaseHelper!.queryAllRows(table: 'cache');

      List<cacheBook.CacheBook> cacheBooks = [];

      _data.forEach((Map<String, dynamic> book) {
        cacheBooks.add(cacheBook.CacheBook.fromDatabase(book));
      });

      emit(TinglaCompleted(response: cacheBooks));
    } catch (e) {
      emit(TinglaError("READ BOOK SCREEN ERROR: $e"));
    }
  }

  // for get all books in database
  Future<void> getDownloadBooks() async {
    try {
      emit(TinglaLoading());
      Variables.localBooks.clear();
      List<Map<String, dynamic>> data =
          await Variables.databaseHelper!.queryAllRows(table: 'book');

      data.forEach((book) {
        Variables.localBooks.add(localBookSchema.Book.fromDatabase(book));
      });

      emit(TinglaCompleted());
    } catch (e) {
      emit(TinglaError("SAVED SCREEN ERROR: $e"));
    }
  }
}
