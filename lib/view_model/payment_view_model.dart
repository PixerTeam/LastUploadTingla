import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/model/payment_repository.dart';

class PaymentViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  ApiResponse get response => _apiResponse;

  set setResponse(ApiResponse response) {
    _apiResponse = response;
    notifyListeners();
  }

  Future<void> createPaymentOson({required id}) async {
    _apiResponse = ApiResponse.loading('Sending requset');
    notifyListeners();

    try {
      Map<String, dynamic> response = await PaymentRepository().createPaymentOson(id: id);
      _apiResponse = ApiResponse.completed(response);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }

    notifyListeners();
  }
}
