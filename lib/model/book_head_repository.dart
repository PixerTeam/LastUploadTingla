import 'dart:io';

import 'package:tingla/schema/head_schema.dart';
import 'package:tingla/variables/variables.dart';

import 'services/api_service.dart';
import 'services/base_service.dart';

class BookHeadRepository {
  final BaseService _networkBookService = ApiService();

  Future<HeadSchema> getNetworkBookHeads({required id}) async {
    dynamic response = await _networkBookService.getResponse(
      'heads/$id',
      params: {
        HttpHeaders.contentTypeHeader: "application/json",
        "authorization": Variables.userToken!,
      },
    );

    return HeadSchema.fromJson(response['data']);
  }
}
