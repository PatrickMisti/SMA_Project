import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfigWrapper {
  static final _apiUrl = dotenv.maybeGet('API_URL') ?? FileSystemException("API_Url not found!");

  static String get popularSeriesUrl => '$_apiUrl/api/serienstream/popular';
}