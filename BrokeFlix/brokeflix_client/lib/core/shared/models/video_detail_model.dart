import 'package:brokeflix_client/core/shared/models/video_detail_stream_model.dart';

class VideoDetail {
  final String title;
  final String originalTitle;
  final String description;
  final List<VideoDetailStream> streams;

  VideoDetail({
    required this.title,
    required this.originalTitle,
    required this.description,
    required this.streams,
  });

  factory VideoDetail.fromJson(Map<String, dynamic> json) {
    return VideoDetail(
      title: json['title'] as String,
      originalTitle: json['originalTitle'] as String,
      description: json['description'] as String,
      streams: (json['streams'] as List)
          .map((e) => VideoDetailStream.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
