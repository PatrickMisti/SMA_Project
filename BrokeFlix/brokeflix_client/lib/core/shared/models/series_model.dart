import 'package:brokeflix_client/core/shared/models/rating_model.dart';

class Series {
  final String title;
  final String description;
  final String bannerUrl;
  final int yearStart;
  final int? yearEnd;
  final List<String> directors;
  final List<String> actors;
  final List<String> creators;
  final List<String> countriesOfOrigin;
  final List<String> genres;
  final int ageRating;
  final Rating rating;
  final String? imdbUrl;
  final String? trailerUrl;
  final bool hasMovies;
  final int seasonsCount;

  Series({
    required this.title,
    required this.description,
    required this.bannerUrl,
    required this.yearStart,
    this.yearEnd,
    required this.directors,
    required this.actors,
    required this.creators,
    required this.countriesOfOrigin,
    required this.genres,
    required this.ageRating,
    required this.rating,
    this.imdbUrl,
    this.trailerUrl,
    required this.hasMovies,
    required this.seasonsCount,
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      title: json['title'],
      description: json['description'],
      bannerUrl: json['bannerUrl'],
      yearStart: json['yearStart'],
      yearEnd: json['yearEnd'],
      directors: List<String>.from(json['directors'] ?? []),
      actors: List<String>.from(json['actors'] ?? []),
      creators: List<String>.from(json['creators'] ?? []),
      countriesOfOrigin: List<String>.from(json['countriesOfOrigin'] ?? []),
      genres: List<String>.from(json['genres'] ?? []),
      ageRating: json['ageRating'],
      rating: Rating.fromJson(json['rating']),
      imdbUrl: json['imdbUrl'],
      trailerUrl: json['trailerUrl'],
      hasMovies: json['hasMovies'],
      seasonsCount: json['seasonsCount'],
    );
  }
}