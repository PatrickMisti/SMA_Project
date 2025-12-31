import 'package:brokeflix_client/core/shared/data_service.dart';
import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:brokeflix_client/core/shared/utils/app_logger.dart';
import 'package:brokeflix_client/core/shared/utils/interfaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';

class PopularViewModel extends BaseViewModel implements RefreshBasis {
  final dataService = GetIt.I.get<DataService>();
  final logger = AppLogger.getLogger('PopularViewModel');

  BehaviorSubject<List<Series>?> get popularSeriesStream =>
      dataService.popularSeriesStream;

  registerServices() {
    if (popularSeriesStream.valueOrNull == null) {
      logger.fine("Fetching popular series for the first time.");
      dataService
          .fetchPopularSeries()
          .catchError(
              (onError) {
            logger.info("http error!");
            popularSeriesStream.add(null);
          });
    }
  }

  @override
  Future<void> refreshUi() async {
    logger.fine("Refreshing popular series.");
    dataService.fetchPopularSeries();
  }
}