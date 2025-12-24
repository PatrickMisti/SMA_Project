

import 'package:brokeflix_client/core/shared/models/hoster_enum.dart';
import 'package:brokeflix_client/core/shared/utils/hoster_ext.dart';

class VideoUrlRequest {
  final Hoster hoster;
  final String url;

  VideoUrlRequest({
    required this.hoster,
    required this.url,
  });

  Map<String, dynamic> toJson() {
    return {
      'host': hoster.displayName,
      'url': url,
    };
  }
}