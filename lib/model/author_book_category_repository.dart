import 'dart:io';

import 'package:tingla/schema/author_book_schema.dart';
import 'package:tingla/variables/variables.dart';

import 'services/api_service.dart';
import 'services/base_service.dart';

class AuthorBookCategoryRepository {
  final BaseService _service = ApiService();

  Future<List<AuthorBook>> getAuthorBookCategory({required String authorId}) async {
    dynamic response = await _service.getResponse(
      'books/authors/$authorId',
      params: {
        HttpHeaders.contentTypeHeader: "application/json",
        "authorization": Variables.userToken!,
      },
    );

    return (response['data']['books'].first['books'] as List).map((e) => AuthorBook.fromJson(e, response['data']['books'].first)).toList();
  }
}
