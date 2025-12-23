

import 'dart:async';

import 'package:brokeflix_client/core/shared/models/rating_model.dart';
import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class DataService implements Disposable{
  BehaviorSubject<Series?> _popularSeriesSubject;

  DataService() : _popularSeriesSubject = BehaviorSubject<Series?>();

  Stream<Series?> get popularSeriesStream => _popularSeriesSubject.stream;

  fetchPopularSeries() async {
    // Simulate a network call with a delay
    await Future.delayed(Duration(seconds: 2));

    // Dummy data for demonstration purposes
    Series popularSeries = Series(
      title: "Example Series",
      description: "An example series description.",
      bannerUrl: "https://example.com/banner.jpg",
      yearStart: 2020,
      directors: ["Director 1", "Director 2"],
      actors: ["Actor 1", "Actor 2"],
      creators: ["Creator 1"],
      countriesOfOrigin: ["Country 1"],
      genres: ["Genre 1", "Genre 2"],
      ageRating: 16,
      rating: Rating(value: 8.5, votes: 1000),
      hasMovies: true,
      seasonsCount: 3,
    );

    // Add the fetched series to the stream
    _popularSeriesSubject.add(popularSeries);
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