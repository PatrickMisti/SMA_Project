

import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class FullscreenVideoPlayerViewModel extends BaseViewModel {
  VideoPlayerController controller;
  bool _showControls = false;

  FullscreenVideoPlayerViewModel({
    required this.controller,
  });

  void togglePlay() {
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    notifyListeners();
  }

  void toggleShowControls() {
    _showControls = !_showControls;
    notifyListeners();
  }

  bool get showControls => _showControls;

  double get aspectRatio => controller.value.aspectRatio;
}