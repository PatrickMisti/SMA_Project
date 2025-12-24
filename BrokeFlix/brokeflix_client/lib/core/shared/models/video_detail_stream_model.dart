import 'package:brokeflix_client/core/shared/models/hoster_enum.dart';
import 'package:brokeflix_client/core/shared/models/language_model.dart';
import 'package:brokeflix_client/core/shared/utils/hoster_ext.dart';

class VideoDetailStream {
  final String videoUrl;
  final Hoster hoster;
  final Language language;

  VideoDetailStream({
    required this.videoUrl,
    required this.hoster,
    required this.language,
  });

  factory VideoDetailStream.fromJson(Map<String, dynamic> json) {
    return VideoDetailStream(
      videoUrl: json['videoUrl'] as String,
      hoster: (json['hoster'] as String).toHoster(),
      language: (json['language'] as Map<String, dynamic>).isNotEmpty
          ? Language.fromJson(json['language'] as Map<String, dynamic>)
          : Language(audio: 'Unknown', subtitle: null),
    );
  }
}