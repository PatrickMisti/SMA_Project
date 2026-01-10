import 'dart:async';

import 'package:brokeflix_client/core/shared/models/group_series_model.dart';
import 'package:brokeflix_client/core/shared/models/search_series_model.dart';
import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:brokeflix_client/core/shared/utils/app_logger.dart';
import 'package:brokeflix_client/core/shared/utils/config_wrapper.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:brokeflix_client/core/shared/utils/http_wrapper.dart' as http;

class DataService implements Disposable {
  final _logger = AppLogger.getLogger("DataService");

  final BehaviorSubject<List<Series>?> _popularSeriesSubject;
  final BehaviorSubject<List<GroupSeries>> _allGroupedSubject;
  final BehaviorSubject<List<SearchSeries>?> _searchSeriesSubject;

  DataService()
    : _popularSeriesSubject = BehaviorSubject<List<Series>?>(),
      _allGroupedSubject = BehaviorSubject<List<GroupSeries>>(),
      _searchSeriesSubject = BehaviorSubject<List<SearchSeries>?>.seeded(null);

  BehaviorSubject<List<Series>?> get popularSeriesStream =>
      _popularSeriesSubject;

  BehaviorSubject<List<GroupSeries>> get allGroupSeriesStream =>
      _allGroupedSubject;

  BehaviorSubject<List<SearchSeries>?> get searchSeriesStream =>
      _searchSeriesSubject;

  Future<void> fetchPopularSeries() async {
    return http.getList(
      ConfigWrapper.popularSeriesUrl,
      Series.fromJson,
    ).then((seriesList) => _popularSeriesSubject.add(seriesList));
  }

  Future<void> fetchAllGroupSeries() async {
    try{
      final seriesList = await http.getList(
        ConfigWrapper.allSeriesUrl,
        GroupSeries.fromJson,
      );
      _allGroupedSubject.add(seriesList);
    } catch (e) {
      _logger.warning("Loading all series failed!");
    }
  }

  Future<void> fetchSearchSeries(String search) async {
    try {
      final searchList = await http.getListWithQuery(
        ConfigWrapper.apiUrl,
        ConfigWrapper.searchPath,
        {"search": search},
        SearchSeries.fromJson,
      );
      _searchSeriesSubject.add(searchList);
    }
    catch (e)
    {
      _logger.fine("Search exception: $e");
      _searchSeriesSubject.add(null);
    }
  }

  Future<Series?> fetchSeriesOnTitle(String title) async {
    try {
      final series = await http.get(ConfigWrapper.seriesUrl(title), Series.fromJson);
      return series;
    } catch (e) {
      _logger.shout("Error to load Series on tile!");
      return null;
    }
  }

  static void props() {
    final getIt = GetIt.I;
    getIt.registerSingleton<DataService>(DataService());
  }

  @override
  FutureOr onDispose() {
    _popularSeriesSubject.close();
  }
}
