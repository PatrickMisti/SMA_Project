import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:stacked/stacked.dart';

class SeriesDetailViewModel extends BaseViewModel {
  final Series _series;
  SeriesDetailViewModel(Series series): _series = series;

  String get heroTag => "series_detail_${_series.bannerUrl}";
}