import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfigWrapper {
  static final _apiUrl = dotenv.maybeGet('API_URL') ?? FileSystemException("API_Url not found!");

  static String get popularSeriesUrl => '$_apiUrl/api/serienstream/popular';

  static String get allSeriesUrl => '$_apiUrl/api/serienstream/all';

  static String seasonUrl(String seriesName) => '$_apiUrl/api/serienstream/$seriesName';

  static String episodeOfSeasonUrl(String seriesName, int season) => '$_apiUrl/api/serienstream/$seriesName/season/$season';

  static String episodeUrl(String seriesName, int season, int episode) => '$_apiUrl/api/serienstream/$seriesName/season/$season/episode/$episode';

  static String get videoUrl => '$_apiUrl/api/serienstream/streamurl';
}