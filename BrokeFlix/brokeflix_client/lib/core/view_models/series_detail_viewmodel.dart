import 'package:brokeflix_client/core/shared/models/episode_model.dart';
import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:brokeflix_client/core/shared/utils/app_logger.dart';
import 'package:brokeflix_client/core/shared/utils/config_wrapper.dart';
import 'package:stacked/stacked.dart';

import 'package:brokeflix_client/core/shared/utils/http_wrapper.dart' as http;

class SeriesDetailViewModel extends BaseViewModel {
  final Series series;
  final logger = AppLogger.getLogger("SeriesDetailViewModel");

  SeriesDetailViewModel({required this.series});

  String get heroTag => "series_detail_${series.bannerUrl}";

  Future<Series> fetchSeasonFromName() async {
    final fetchSeries = await http.get(ConfigWrapper.seasonUrl(series.title),Series.fromJson);
    return fetchSeries;
  }

  Future<List<Episode>> fetchEpisodesFromSeason(int season) async {
    final episodes = await http.getList(ConfigWrapper.episodeOfSeasonUrl(series.title, season), Episode.fromJson);
    logger.info("fetch data from series ${series.title} season $season: ${episodes.length} episodes found");
    return episodes;
  }
}