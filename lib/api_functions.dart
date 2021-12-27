import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:tingla/schema/author_book_schema.dart' as authorBook;
import 'package:tingla/schema/best_book_schema.dart' as bestBook;
import 'package:tingla/schema/book_schema.dart' as book;
import 'package:tingla/schema/searched_book_schema.dart' as searchedBooks;
import 'package:tingla/schema/cache_book_schema.dart' as cacheBook;
import 'package:tingla/schema/head_schema.dart' as headSchema;
import 'package:tingla/schema/one_category_schema.dart';
import 'package:tingla/database/book_schema_to_database.dart' as bookSchema;

import 'schema/category_schema.dart';
import 'schema/profile_data_schema.dart';
import 'variables/variables.dart';

Future<List<Category>> getCategoriesData() async {
  Variables.categories.clear();

  String url = "https://tingla.pixer.uz/categories/all";
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": Variables.userToken!,
    },
  );

  if (response.statusCode == 200) {
    var _data = jsonDecode(response.body);

    List<Category> _allData = [];

    _data['data'].forEach(
      (category) => _allData.add(
        Category.fromJson(category),
      ),
    );

    return _allData;
  } else {
    throw Exception(
        "FAIL TO LOAD DATA! STATUS CODE: ${response.statusCode} RESPONSE: ${response.body}");
  }
}

Future<OneCategory> getOneCategoryData(categoryId) async {
  String url = "https://tingla.pixer.uz/categories/$categoryId";

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": Variables.userToken!,
    },
  );

  if (response.statusCode == 200) {
    var _data = jsonDecode(response.body);
    return OneCategory.fromJson(_data['data']);
  } else {
    throw Exception("HOME SCREEN FAIL TO LOAD DATA!");
  }
}

Future<List<authorBook.AuthorBook>> getAuthorCategoryData(authorId) async {
  String url = "https://tingla.pixer.uz/books/authors/$authorId";

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": Variables.userToken!,
    },
  );

  print(response.body);

  if (response.statusCode == 200) {
    var _data = jsonDecode(response.body);
    return (_data['data']['books'].first['books'] as List).map((e) => authorBook.AuthorBook.fromJson(e, _data['data']['books'].first)).toList();
  } else {
    throw Exception("HOME SCREEN FAIL TO LOAD DATA!");
  }
}

Future<book.Book> getOneBookData(bookId) async {
  String url = "https://tingla.pixer.uz/books/$bookId";

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": Variables.userToken!,
    },
  );

  if (response.statusCode == 200) {
    var _data = jsonDecode(response.body);

    return book.Book.fromJson(_data);
  } else {
    throw Exception("BOOK SCREEN FAIL TO LOAD DATA!");
  }
}

Future<LocalProfileData?> getProfileData() async {
  String url = "https://tingla.pixer.uz/users/profile";

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": Variables.userToken!,
    },
  );

  if (response.statusCode == 200) {
    var _data = jsonDecode(response.body);

    if (Variables.profileData != null) {
      await Variables.databaseHelper!
          .update(ProfileData.fromJson(_data), table: "profile");
    } else {
      await Variables.databaseHelper!
          .insert(ProfileData.fromJson(_data), table: "profile");
    }
  } else {
    throw Exception("PROFILE SCREEN FAIL TO LOAD DATA!");
  }

  dynamic _data =
      await Variables.databaseHelper!.queryAllRows(table: "profile");

  return LocalProfileData.fromJson(_data[0]);
}

Future<void> editPersonlaData() async {
  bool _changed = false;

  if (Variables.userPhoto == null && Variables.profileData!.userPhoto != null) {
    await deleteProfilePhoto();
  }

  if (Variables.newUserPhoto != null) {
    String url = "https://tingla.pixer.uz/users/profile/edit-photo";

    var request = http.MultipartRequest(
      'PATCH',
      Uri.parse(url),
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": Variables.userToken!,
    };

    request.files.add(
      http.MultipartFile(
        'file',
        Variables.newUserPhoto!.readAsBytes().asStream(),
        Variables.newUserPhoto!.lengthSync(),
        filename: "image.jpeg",
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 202) {
      Map<String, dynamic> userPhoto =
          jsonDecode(await response.stream.bytesToString());

      _changed = true;
    } else {
      throw "FAILED CREATE PHOTO: ${response.statusCode}";
    }
  }

  if (Variables.newUserName != null) {
    String url = "https://tingla.pixer.uz/users/profile/edit";

    http.Response response = await http.patch(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "authorization": Variables.userToken!,
      },
      body: jsonEncode({
        "name": Variables.newUserName,
        "birth_date": DateTime.now().toString(),
        "gender": 2
      }),
    );

    if (response.statusCode == 202) {
      _changed = true;

      var _data = jsonDecode(response.body);
      if (_data['ok']) {
      } else {}
    } else {
      throw "FAILED EDIT PERSONAL DATA";
    }
  }

  if (_changed) {
    Variables.profileData = await getProfileData();
  }
}

Future<void> deleteProfilePhoto() async {
  String url = "https://tingla.pixer.uz/users/profile/delete-photo";

  http.Response response = await http.delete(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": Variables.userToken!,
    },
  );

  if (response.statusCode == 200) {
    var _data = jsonDecode(response.body);

    Variables.profileData = await getProfileData();
  } else {
    throw Exception("FAIL DELETE PROFILE PHOTO ${response.statusCode}!");
  }
}

Future<headSchema.HeadSchema> getOneHeadData(headId) async {
  String url = "https://tingla.pixer.uz/heads/$headId";

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": Variables.userToken!,
    },
  );

  if (response.statusCode == 200) {
    var _data = jsonDecode(response.body);
    if (_data['ok']) {
      return headSchema.HeadSchema.fromJson(_data['data']);
    } else {
      throw Exception("BOOK SCREEN FAIL TO HEAD LOAD DATA!");
    }
  } else {
    throw Exception("BOOK SCREEN FAIL TO HEAD LOAD DATA!");
  }
}

Future<List<searchedBooks.SearchedBookSchema>?> getSearchData(title) async {
  String url = "https://tingla.pixer.uz/books/search?title=$title";

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": Variables.userToken!,
    },
  );

  if (response.statusCode == 200) {
    var _data = jsonDecode(response.body);
    if (_data['ok']) {
      List books = _data['data']['books'];

      return books.map((book) {
        return searchedBooks.SearchedBookSchema.fromJson(book);
      }).toList();
    } else {
      throw "SEARCH SCREEN FAIL SEARCH DATA!";
    }
  } else {
    throw "SEARCH SCREEN FAIL SEARCH DATA! STATUS CODE: ${response.statusCode}";
  }
}

Future<List<bestBook.BestBook>> getBestBooksData() async {
  String url = "https://tingla.pixer.uz/books/best";

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": Variables.userToken!,
    },
  );

  if (response.statusCode == 200) {
    var _data = jsonDecode(response.body);
    if (_data['ok']) {
      return (_data['data'] as List)
          .map((data) => bestBook.BestBook.fromJson(data))
          .toList();
    } else {
      throw Exception("SEARCH SCREEN FAIL TO BEST BOOKS LOAD DATA!");
    }
  } else {
    throw Exception("SEARCH SCREEN FAIL TO BEST BOOKS LOAD DATA!");
  }
}

Future getBuyBook(bookId) async {
  String url = "https://tingla.pixer.uz/books/buy/$bookId";

  http.Response response = await http.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": Variables.userToken!,
    },
  );

  if (response.statusCode == 201 || response.statusCode == 400) {
    final _data = jsonDecode(response.body);
    return _data;
  } else {
    throw "FAILED BUY BOOK DATA";
  }
}

Future<int> downloadBook(book.Book newBook) async {
  Variables.downloadNotifier.value = DownloadState.downloading;

  // list for write to database
  List<bookSchema.Head> headsForDatabase = [];
  List<bookSchema.Audio> audiosForDatabase = [];

  try {
    // ----------------------------- GET ALL DATA FROM NETWORK -----------------------------------------
    // book for database ready
    bookSchema.Book bookForDatabase =
        bookSchema.Book.fromJson(newBook.toJson());

    // check heads
    if (newBook.data!.heads!.isNotEmpty) {
      for (book.Head head in newBook.data!.heads!) {
        // add heads list
        headsForDatabase.add(bookSchema.Head.fromJson(head.toJson()));

        // get one head for audio
        headSchema.HeadSchema newHead = await getOneHeadData(head.headId);

        // check head audio list
        if (newHead.audios != null) {
          // check is not empty
          if (newHead.audios!.isNotEmpty) {
            for (headSchema.Audio audio in newHead.audios!) {
              // choose first audio

              // add audio list for database
              audiosForDatabase.add(bookSchema.Audio.fromJson(audio.toJson()));
            }
          } else {
            throw 'DOWNLOAD ERROR: AUDIO LIST IS EMPTY';
          }
        } else {
          throw 'DOWNLOAD ERROR: AUDIO LIST IS NULL';
        }
      }
    } else {
      throw 'DOWNLOAD ERROR: HEADS IS EMPTY';
    }

    // -------------------------------- WRITING ALL DATA TO DATABASE --------------------------------------
    // result download
    int result = 0;
    bool isExist = false;
    // check result book
    for (var i = 0; i < headsForDatabase.length; i++) {
      // write head to database
      isExist = await Variables.databaseHelper!
          .isExist(headsForDatabase[i].headId!, table: 'head');

      if (!isExist) {
        result =
            await Variables.databaseHelper!.downloadHead(headsForDatabase[i]);

        if (result == 0) {
          // if has error
          await Variables.databaseHelper!
              .delete(bookForDatabase.id, table: 'book');

          throw 'Head download error at index $i';
        }
      }

      isExist = await Variables.databaseHelper!
          .isExist(audiosForDatabase[i].audioId!, table: 'audio');

      if (!isExist) {
        // write audio to database
        result =
            await Variables.databaseHelper!.downloadAudio(audiosForDatabase[i]);

        if (result == 0) {
          // if has error
          await Variables.databaseHelper!
              .delete(bookForDatabase.id, table: 'book');

          throw 'Audio download error at index $i';
        }
      }
    }

    isExist = await Variables.databaseHelper!
        .isExist(bookForDatabase.id!, table: 'book');

    if (!isExist) {
      // write book to database
      result = await Variables.databaseHelper!.downloadBook(bookForDatabase);

      if (result == 0) {
        // if has error
        await Variables.databaseHelper!
            .delete(bookForDatabase.id, table: 'book');

        throw 'Book download error';
      }
    }

    cacheBook.CacheBook newCacheBook = cacheBook.CacheBook(
      bookId: newBook.data!.id!,
      headIndex: 0,
      headCurrentOffset: 0.0,
      headMaxOffset: 0.0,
      audioCurrentOffset: 0,
      audioMaxOffset: 0,
    );

    isExist = await Variables.databaseHelper!
        .isExist(bookForDatabase.id!, table: 'cache');

    if (!isExist) {
      await Variables.databaseHelper!.insert(newCacheBook, table: 'cache');
    }

    Variables.downloadNotifier.value = DownloadState.downloaded;
    await Future.delayed(const Duration(seconds: 3));

    Variables.downloadNotifier.value = DownloadState.notDonwloaded;
    return 1;
  } catch (e) {
    Variables.downloadNotifier.value = DownloadState.errorDownloading;
    await Future.delayed(const Duration(seconds: 3));
    Variables.downloadNotifier.value = DownloadState.notDonwloaded;

    return 0;
  }
}

Future<void> sendComment(String comment, String id) async {
  String url = "https://tingla.pixer.uz/comments/create/$id";
  http.Response response = await http.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": Variables.userToken!,
    },
    body: jsonEncode({"body": comment}),
  );

  if (response.statusCode != 201) {
    throw "FAILED SEND COMMENT STATUS CODE: ${response.statusCode} RESPONSE: ${response.body}";
  }
}

Future<void> sendRate(int rate, String id) async {
  String url = "https://tingla.pixer.uz/books/rate/$id";
  http.Response response = await http.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": Variables.userToken!,
    },
    body: jsonEncode({"rating": rate}),
  );

  if (response.statusCode != 200) {
    throw "FAILED SEND RATE STATUS CODE: ${response.statusCode} RESPONSE: ${response.body}";
  }
}

Future<List<dynamic>> getComments(String id) async {
  String url = "https://tingla.pixer.uz/comments/$id";
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "authorization": Variables.userToken!,
    },
  );

  if (response.statusCode == 200) {
    return await jsonDecode(response.body)['data'];
  } else {
    throw "FAILED GET COMMENTS: ${response.statusCode} RESPONSE: ${response.body}";
  }
}
