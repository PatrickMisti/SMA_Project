import 'dart:convert';

import 'package:http/http.dart' as http;

typedef Parser<T> = T Function(Map<String, dynamic> json);

Future _getRaw(String url) async {
  final uri = Uri.parse(url);
  var response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed to load data');
  }

  return jsonDecode(response.body);
}

Future<T> get<T>(String url, Parser<T> parser) async {
  final data = await _getRaw(url);
  return parser(data);
}

Future<List<T>> getList<T>(String url, Parser<T> parser) async {
  final data = await _getRaw(url);
  return (data as List).map<T>((json) => parser(json)).toList();
}