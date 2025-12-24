import 'package:brokeflix_client/core/shared/models/language_model.dart';

class VideoDetailStream {
  final String videoUrl;
  final String hoster;
  final Language language;

  VideoDetailStream({
    required this.videoUrl,
    required this.hoster,
    required this.language,
  });

  factory VideoDetailStream.fromJson(Map<String, dynamic> json) {
    return VideoDetailStream(
      videoUrl: json['videoUrl'] as String,
      hoster: json['hoster'] as String,
      language: (json['language'] as Map<String, dynamic>).isNotEmpty
          ? Language.fromJson(json['language'] as Map<String, dynamic>)
          : Language(audio: 'Unknown', subtitle: null),
    );
  }
}