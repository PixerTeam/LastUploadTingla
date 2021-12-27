import 'dart:io';

import 'package:tingla/schema/book_schema.dart';
import 'package:tingla/variables/variables.dart';

import 'services/api_service.dart';
import 'services/base_service.dart';

class NetworkBookRepository {
  final BaseService _networkBookService = ApiService();

  Future<Book> getNetworkBook({required id}) async {
    dynamic response = await _networkBookService.getResponse(
      'books/$id',
      params: {
        HttpHeaders.contentTypeHeader: "application/json",
        "authorization": Variables.userToken!,
      },
    );

    return Book.fromJson(response);
  }
}
