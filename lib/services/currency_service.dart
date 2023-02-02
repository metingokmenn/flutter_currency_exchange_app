import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CurrencyService {
  Map<String, dynamic> data = {};
  Dio dio = Dio();

  Future<Map<String, dynamic>> getData() async {
    final String _api =
        'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies.json';
    var response = await dio.get(_api);
    if (response.statusCode == 200) {
      data = response.data;
      return data;
    } else {
      data = {};
      return data;
    }
  }

  Future<String> convertCurrency(String base, String target) async {
    Map<String, dynamic> data = {};
    final String _api =
        'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/$base/$target.json';
    var response = await dio.get(_api);
    if (response.statusCode == 200) {
      data = response.data;
      debugPrint(data[target].toString());
      return data[target].toString();
    } else {
      data = {};
      return '0';
    }
  }
}
