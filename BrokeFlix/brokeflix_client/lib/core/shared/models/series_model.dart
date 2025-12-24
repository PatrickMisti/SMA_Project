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
/*
    * {
    "title": "Fallout",
    "description": "Die Spielereihe Live-Adaption ist im 22. Jahrhundert angesiedelt und setzt nach einem globalen Nuklearkrieg ein, durch den sich die Welt in eine postapokalyptische Dystopie verwandelt hat. Nachdem nahezu die komplette Erde durch den Atomkrieg verwüstet wurde, liegt es an den wenigen Überlebenden, in einer lebensfeindlichen und todbringenden Welt, eine neue Zivilisation aufzubauen. Im Zentrum stehen die Bewohner des sogenannten „Vault 33“ - Teil eines Netzwerks von Atombunkern. Nach einem ernsten Zwischenfall, liegt es an einem ihrer Mitglieder, die sichere Behausung zu verlassen und sich in die gefährlich brutale, feindselige, wilde und unbarmherzige Einöde des zerstörten Los Angeleszu begeben.",
    "bannerUrl": "http://186.2.175.5/public/img/cover/fallout-stream-cover-B6pntUcINAf2eK3xAjciZRJ40bEpfojh_220x330.jpg",
    "yearStart": 2024,
    "yearEnd": null,
    "directors": [
      "Jonathan Nolan",
      "Claire Killner",
      "Frederick E.O. Toye",
      "Daniel Gray Longino",
      "Wayne Yip"
    ],
    "actors": [
      "Walton Goggins",
      "Ella Purnell",
      "Kyle MacLachlan",
      "Aaron Moten",
      "Xelia Mendes-Jones",
      "Moises Arias",
      "Johnny Pemberton",
      "Leer Leary",
      "Dave Register",
      "Rodrigo Luzzi"
    ],
    "creators": [
      "James Altman",
      "Karey Dornetto",
      "Kieran Fitzgerald",
      "Todd Howard",
      "Lisa Joy",
      "Margot Lulick",
      "Carson Mell",
      "Jonathan Nolan"
    ],
    "countriesOfOrigin": [
      "USA"
    ],
    "genres": [
      "Science-Fiction",
      "Abenteuer",
      "Action",
      "Horror",
      "Amazon Originals"
    ],
    "ageRating": 16,
    "rating": {
      "value": 4,
      "maximum": 5,
      "count": 868
    },
    "imdbUrl": "https://www.imdb.com/title/tt12637874",
    "trailerUrl": "https://www.youtube.com/watch?v=DVLwGrZ4k_E",
    "hasMovies": false,
    "seasonsCount": 2
  },*/