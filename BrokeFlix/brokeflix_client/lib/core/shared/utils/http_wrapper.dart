import 'dart:convert';

import 'package:brokeflix_client/core/shared/utils/app_logger.dart';
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

final _logger = AppLogger.getLogger("HttpWrapper");

Future<T> get<T>(String url, Parser<T> parser) async {
  _logger.info("Request: $url");
  final data = await _getRaw(url);
  return parser(data);
}

Future<List<T>> getList<T>(String url, Parser<T> parser) async {
  _logger.info("Request: $url");
  final data = await _getRaw(url);
  return (data as List).map<T>((json) => parser(json)).toList();
}

Future<List<T>> getListWithQuery<T>(String url, String path, Map<String, String> query, Parser<T> parser) async {
  var base = Uri.parse(url);

  final uri = base.replace(
    path: path,
    queryParameters: query
  );

  _logger.info("Http Get Search with ${uri.toString()}");
  var response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception("Failed to load data");
  }
  final data = jsonDecode(response.body);
  return (data as List).map<T>((json) => parser(json)).toList();
}

Future<T> post<T>(String url, Map<String, dynamic> body, Parser<T> parser) async {
  final data = await postRaw(url, body);
  return parser(jsonDecode(data));
}

Future postRaw(String url, Map<String, dynamic> body) async {
  _logger.info("Request: $url");
  final uri = Uri.parse(url);
  var response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(body),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load data');
  }

  return response.body;
}