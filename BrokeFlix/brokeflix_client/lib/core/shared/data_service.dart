import 'dart:async';

import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:brokeflix_client/core/shared/utils/config_wrapper.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:brokeflix_client/core/shared/utils/http_wrapper.dart' as http;

class DataService implements Disposable {
  final BehaviorSubject<List<Series>> _popularSeriesSubject;

  DataService() : _popularSeriesSubject = BehaviorSubject<List<Series>>();

  BehaviorSubject<List<Series>> get popularSeriesStream =>
      _popularSeriesSubject;

  fetchPopularSeries() async {
    final seriesList = await http.getList(ConfigWrapper.popularSeriesUrl, Series.fromJson);
    _popularSeriesSubject.add(seriesList);
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
