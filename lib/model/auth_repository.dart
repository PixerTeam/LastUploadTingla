import 'dart:convert';
import 'dart:io';

import 'services/api_service.dart';
import 'services/base_service.dart';

class AuthRepository {
  final BaseService _authService = ApiService();

  Future<Map<String, dynamic>> checkPhoneNumber(String number) async {
    dynamic response = await _authService.postResponse(
      'users/check-phone',
      params: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: jsonEncode({"phone": number}),
    );
    return response;
  }

  Future<Map<String, dynamic>> signIn(String number) async {
    dynamic response = await _authService.postResponse(
      'users/login',
      params: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: jsonEncode({"phone": number}),
    );

    return response;
  } 

  Future<Map<String, dynamic>> signUp(String number, String name) async {
    dynamic response = await _authService.postResponse(
      'users/signup',
      params: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: jsonEncode({
        "name": name,
        "phone": number,
      }),
    );

    return response;
  }
}
