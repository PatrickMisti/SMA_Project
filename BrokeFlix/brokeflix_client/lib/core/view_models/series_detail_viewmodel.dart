import 'package:brokeflix_client/core/shared/models/episode_model.dart';
import 'package:brokeflix_client/core/shared/models/hoster_enum.dart';
import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:brokeflix_client/core/shared/models/utils/VideoUrlRequest.dart';
import 'package:brokeflix_client/core/shared/models/video_detail_model.dart';
import 'package:brokeflix_client/core/shared/utils/app_logger.dart';
import 'package:brokeflix_client/core/shared/utils/config_wrapper.dart';
import 'package:brokeflix_client/core/shared/utils/hoster_ext.dart';
import 'package:stacked/stacked.dart';

import 'package:brokeflix_client/core/shared/utils/http_wrapper.dart' as http;

class SeriesDetailViewModel extends BaseViewModel {
  final Series series;
  final logger = AppLogger.getLogger("SeriesDetailViewModel");

  VideoDetail? selectedEpisode;
  String? selectedHoster;

  SeriesDetailViewModel({required this.series});

  String get heroTag => "series_detail_${series.bannerUrl}";

  Future<Series> fetchSeasonFromName() async {
    final fetchSeries = await http.get(
      ConfigWrapper.seasonUrl(series.title),
      Series.fromJson,
    );
    return fetchSeries;
  }

  Future<List<Episode>> fetchEpisodesFromSeason(int season) async {
    final episodes = await http.getList(
      ConfigWrapper.episodeOfSeasonUrl(series.title, season),
      Episode.fromJson,
    );
    logger.info(
      "fetch data from series ${series.title} season $season: ${episodes
          .length} episodes found",
    );
    return episodes;
  }

  VideoUrlRequest? findVideoUrlFromSelectedEpisodeAndHoster(VideoDetail? detail,
      String? hoster, {
        String language = "german",
      }) {
    if (detail == null) return null;

    try {
      if (hoster == null) {
        logger.warning("Hoster is null, get random hoster url");
        return VideoUrlRequest(hoster: Hoster.unknown, url: detail.streams.first.videoUrl);
      }

      final streamHoster = detail.streams
          .where((s) => s.hoster.displayName == hoster);
      final stream = streamHoster
          .where((s) => s.language.audio.toLowerCase() == language.toLowerCase())
          .firstOrNull;

      return VideoUrlRequest(
          hoster: hoster.toHoster(),
          url: stream == null ? streamHoster.first.videoUrl : stream.videoUrl
      );
    } catch (e) {
      logger.warning("No stream found for hoster $hoster and language $language: $e");
      return null;
    }
  }

  updateSelectedEpisodeAndHoster(int season, int episode, String hoster) async {
    selectedHoster = hoster;
    try {
      logger.info(
        "Fetching episode detail for ${series.title} S${season}E${episode}",
      );
      selectedEpisode = await http.get(
        ConfigWrapper.episodeUrl(series.title, season, episode),
        VideoDetail.fromJson,
      );
    } catch (e) {
      logger.severe("Error fetching episode detail: $e");
      selectedEpisode = null;
    }
    notifyListeners();
  }

  Future<String?> loadVideoUrl() async {
    var videoUrl = findVideoUrlFromSelectedEpisodeAndHoster(selectedEpisode, selectedHoster);
    logger.info("Fetched episode detail: ${selectedEpisode?.title} with $videoUrl sources");

    if (videoUrl == null) {
      logger.severe("No video URL found for selected episode and hoster.");
      return null;
    }

    try {
      final url = await http.postRaw(ConfigWrapper.videoUrl, videoUrl.toJson());
      return url as String;
    } catch (e) {
      logger.severe("Error loading video URL: $e");
      return null;
    }
  }
}