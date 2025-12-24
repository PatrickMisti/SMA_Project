

import 'package:brokeflix_client/core/shared/models/hoster_enum.dart';

extension HosterExt on String {
  Hoster toHoster() {
    switch (toLowerCase()) {
      case 'voe':
        return Hoster.voe;
      case 'doodstream':
        return Hoster.doodstream;
      case 'vidoza':
        return Hoster.vidoza;
      case 'streamtape':
        return Hoster.streamtape;
      default:
        return Hoster.unknown;
    }
  }
}

extension HosterNameExt on Hoster {
  String get displayName {
    switch (this) {
      case Hoster.voe:
        return 'Voe';
      case Hoster.doodstream:
        return 'DoodStream';
      case Hoster.vidoza:
        return 'Vidoza';
      case Hoster.streamtape:
        return 'StreamTape';
      default:
        return 'Unknown';
    }
  }
}