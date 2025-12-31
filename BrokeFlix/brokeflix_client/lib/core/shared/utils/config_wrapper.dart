import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfigWrapper {     //  API_URL_vLocal  //  API_URL
  static final _apiUrl = dotenv.maybeGet('API_URL') ?? FileSystemException("API_Url not found!");

  static String get popularSeriesUrl => '$_apiUrl/api/serienstream/popular';

  static String get apiUrl => _apiUrl.toString();

  static String get allSeriesUrl => '$_apiUrl/api/serienstream/all';

  static String seriesUrl(String title) => '$_apiUrl/api/serienstream/$title';

  static String encodeSeriesUrl(String seriesName) => Uri.encodeComponent(seriesName);

  static String seasonUrl(String seriesName) => '$_apiUrl/api/serienstream/${encodeSeriesUrl(seriesName)}';

  static String episodeOfSeasonUrl(String seriesName, int season) => '$_apiUrl/api/serienstream/${encodeSeriesUrl(seriesName)}/season/$season';

  static String episodeUrl(String seriesName, int season, int episode) => '$_apiUrl/api/serienstream/${encodeSeriesUrl(seriesName)}/season/$season/episode/$episode';

  static String get videoUrl => '$_apiUrl/api/serienstream/streamurl';

  static String get searchPath => '/v1/api/serienstream/search';
}