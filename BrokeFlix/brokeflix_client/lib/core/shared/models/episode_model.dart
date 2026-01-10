import 'package:brokeflix_client/core/shared/models/hoster_enum.dart';
import 'package:brokeflix_client/core/shared/models/language_model.dart';
import 'package:brokeflix_client/core/shared/utils/hoster_ext.dart';
import 'package:flutter/material.dart';

class Episode {
  final int number;
  final String title;
  final String originalTitle;
  final List<Hoster> hosters;
  final List<Language> languages;

  Episode({
    required this.number,
    required this.title,
    required this.originalTitle,
    required this.hosters,
    required this.languages,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      number: json['number'] as int,
      title: json['title'] as String,
      originalTitle: json['originalTitle'] as String,
      hosters: (json['hosters'] as List)
          .map((e) => (e as String).toHoster())
          .toList(),
      languages: (json['languages'] as List)
          .map((e) => Language.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'number': number,
    'title': title,
    'originalTitle': originalTitle,
    'hosters': hosters.map((i) => i.displayName).toList(),
    'languages': languages.map((e) => e.toJson()).toList(),
  };

  DropdownMenuItem<int> toDropdownMenuItem({bool fullTitle = true}) {
    var resTitle = title.isEmpty ? originalTitle: title;
    var text = resTitle.length > 10
        ? '${resTitle.substring(0, 10)}...'
        : resTitle;
    text = fullTitle ? resTitle : text;
    return DropdownMenuItem<int>(
      value: number,
      child: Text(text),
    );
  }

  List<DropdownMenuItem<String>> toHosterMenuItem() {
    return hosters.map((hoster) => DropdownMenuItem<String>(
      value: hoster.displayName,
      child: Text(hoster.displayName),
    )).toList();
  }
}
