class Language {
  final String audio;
  final String subtitle;

  Language({
    required this.audio,
    required this.subtitle,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      audio: json['audio'] as String,
      subtitle: json['subtitle'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'audio': audio,
    'subtitle': subtitle,
  };
}
