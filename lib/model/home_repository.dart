import 'dart:io';

import 'package:tingla/schema/category_schema.dart';
import 'package:tingla/variables/variables.dart';

import 'services/api_service.dart';
import 'services/base_service.dart';

class HomeRepository {
  final BaseService _homeService = ApiService();

  Future<List<Category>> getCategories() async {
    dynamic response = await _homeService.getResponse(
      'categories/all',
      params: {
        HttpHeaders.contentTypeHeader: "application/json",
        "authorization": Variables.userToken!,
      },
    );


    final jsonData = response['data'] as List;

    List<Category> _categories = jsonData.map((tagJson) {
      return Category.fromJson(tagJson);
    }).toList();

    return _categories;
  }
}
