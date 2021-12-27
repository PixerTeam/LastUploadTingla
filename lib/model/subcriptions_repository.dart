import 'dart:io';

import 'package:tingla/schema/subcription_schema.dart';
import 'package:tingla/variables/variables.dart';

import 'services/api_service.dart';
import 'services/base_service.dart';

class SubcriptionsRepository {
  final BaseService _service = ApiService();

  Future<List<Subcription>> getSubcriptions() async {
    dynamic response = await _service.getResponse(
      'users/subscriptions',
      params: {
        HttpHeaders.contentTypeHeader: "application/json",
        "authorization": Variables.userToken!,
      },
    );

    return (response['data']['courses'] as List).map((e) => Subcription.fromJson(e)).toList();
  }
}
