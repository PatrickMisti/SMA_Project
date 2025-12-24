import 'package:brokeflix_client/core/shared/data_service.dart';
import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:brokeflix_client/core/shared/utils/app_logger.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';

class StartViewModel extends BaseViewModel {
  final dataService = GetIt.I.get<DataService>();
  final logger = AppLogger.getLogger('StartViewModel');

  BehaviorSubject<List<Series>> get popularSeriesStream =>
      dataService.popularSeriesStream;

  registerServices() {
    if (popularSeriesStream.valueOrNull == null) {
      logger.fine("Fetching popular series for the first time.");
      dataService.fetchPopularSeries();
    }
  }

  refreshPopularSeries() async {
    logger.fine("Refreshing popular series.");
    await dataService.fetchPopularSeries();
  }
  // Add properties and methods relevant to the StartViewModel here
}