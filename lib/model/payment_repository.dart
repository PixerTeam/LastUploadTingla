import 'dart:convert';
import 'dart:io';

import 'package:tingla/variables/variables.dart';

import 'services/api_service.dart';
import 'services/base_service.dart';

class PaymentRepository {
  final BaseService _service = ApiService();

  Future<Map<String, dynamic>> createPaymentOson({required id}) async {
    
    dynamic response = await _service.postResponse(
      'payments/oson/create/$id',
      params: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: json.encode({
        "return_url": "https://tingla.pixer.uz",
        "authorization": Variables.userToken
      }),
    );

    return response;
  }
}
