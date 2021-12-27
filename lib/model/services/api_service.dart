import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import 'package:tingla/model/apis/app_exception.dart';

import 'base_service.dart';

class ApiService extends BaseService {
  @override
  Future postResponse(
    String url, {
    Map<String, String>? params,
    Object? body,
  }) async {

    dynamic responseJson;
    
    try {
      final response = await http.post(
        Uri.parse(baseUrl + url),
        headers: params,
        body: body,
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("Ilitimos internetga ulanib qayta urinib ko'ring!");
    }
    return responseJson;
  }

  @override
  Future getResponse(String url, {Map<String, String>? params}) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse(baseUrl + url),
        headers: params,
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(
          "Ilitimos internetga ulanib qayta urinib ko'ring!");
    }

    return responseJson;
  }

  @visibleForTesting
  dynamic returnResponse(response) {
    
    
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException("Telefon raqam noto'g'ri!");
      case 401:
      case 403:
        throw UnauthorisedException("Token is failed!");
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server with status code : ${response.statusCode}');
    }
  }
}
