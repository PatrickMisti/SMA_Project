import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class FullscreenVideoPlayerViewModel extends BaseViewModel {
  VideoPlayerController controller;
  bool _showControls = false;

  FullscreenVideoPlayerViewModel({
    required this.controller,
  }) {
    controller.addListener(_onControllerUpdated);
  }

  void _onControllerUpdated() => notifyListeners();

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

  Duration get position => controller.value.position;
  Duration get duration => controller.value.duration;

  double get positionMs => position.inMilliseconds.toDouble().clamp(0.0, durationMs);
  double get durationMs => duration.inMilliseconds.toDouble().clamp(0.0, double.infinity);

  Future<void> seekTo(double milliseconds) async {
    final position = Duration(milliseconds: milliseconds.toInt());
    await controller.seekTo(position);
    notifyListeners();
  }

  String formatDuration(Duration d) {
    final two = (int n) => n.toString().padLeft(2, '0');
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    if (hours > 0) return '${two(hours)}:${two(minutes)}:${two(seconds)}';
    return '${two(minutes)}:${two(seconds)}';
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerUpdated);
    super.dispose();
  }
}