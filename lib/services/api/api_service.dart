// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../responces/countries_dto.dart';

class ApiService {
  String baseUrl;
  ApiService({
    required this.baseUrl,
  });

  Future<List<CountriesDTO>> getCountries() async {
    var url = Uri.https(baseUrl, 'v3.1/all');

    final response = await http.get(url);
    return _parseList(response, (e) => CountriesDTO.fromJson(e));
  }

  List<T> _parseList<T>(http.Response response, T Function(dynamic) parser) {
    if (response.statusCode == 200) {
      final body = response.body;
      final List<dynamic> result = jsonDecode(body);
      return result.map(parser).toList();
    }
    throw 'Failed to parse list response ${response.request?.url}';
  }
}
