import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';
import 'package:volume_controller/volume_controller.dart';

class VideoPlayerViewModel extends BaseViewModel {
  late VideoPlayerController _controller;
  late final Future<void> initFuture;
  late VoidCallback _videoListener;
  bool _disposed = false;

  ValueNotifier<bool> isTapped = ValueNotifier(true);
  Timer? _tapTimer;
  final _timeSpan = 5;

  ValueNotifier<bool> isPlaying = ValueNotifier(false);
  ValueNotifier<bool> isFullScreen = ValueNotifier(false);
  ValueNotifier<Duration> time = ValueNotifier(Duration.zero);
  ValueNotifier<Duration> currentTime = ValueNotifier(Duration.zero);

  VolumeController? _volumeController;
  StreamSubscription<double>? _volumeStream;
  ValueNotifier<double> currentVolume = ValueNotifier<double>(0);

  final String title;

  VideoPlayerViewModel({required String path, required this.title}) {
    if (checkUrl(path)) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(path));
    } else {
      final videoPath = File(path);
      _controller = VideoPlayerController.file(videoPath);
    }
    if (!kIsWeb) {
      registerVolume();
    }

    _videoListener = () {
      if (_disposed) return;

      update();
    };

    initFuture = _controller
        .initialize()
        .then((_) {
          pause();
          time.value = _controller.value.duration;
          _controller.addListener(_videoListener);
        })
        .catchError((error) {
          debugPrint("error : $error");
        });
  }

  void registerVolume() {
    _volumeController = VolumeController.instance;
    _volumeController?.showSystemUI = false;

    _volumeStream = _volumeController?.addListener((volume) {
      currentVolume.value = volume;
      _controller.setVolume(volume);
    }, fetchInitialVolume: true);
  }

  void update() {
    if (_disposed) return;
    currentTime.value = _controller.value.position;

    final v = _controller.value;
    if (isVideoEnd(v) && isPlaying.value) {
      pause();
    }
  }

  VideoPlayerController get controller => _controller;

  void toggleFullScreen() => isFullScreen.value = !isFullScreen.value;

  void changeVolume(double vol) => _volumeController?.setVolume(vol);

  void togglePlaying() => isPlaying.value ? pause() : play();

  void pause() {
    timerWrapper(() {
      _controller.pause();
      isPlaying.value = false;
    });
  }

  void play() {
    timerWrapper(() {
      _controller.play();
      isPlaying.value = true;
    });
  }

  void seekTo(double slider) {
    final val = time.value * slider;
    _controller.seekTo(val);
  }

  void seekStart() => _tapTimer?.cancel();

  void seekEnd() => timerWrapper(null);

  double get getPosition {
    return currentTime.value.inMilliseconds / time.value.inMilliseconds;
  }

  onTapOrHover(bool value) {
    isTapped.value = value;

    _tapTimer?.cancel();

    if (value) {
      _tapTimer = Timer(
        Duration(seconds: _timeSpan),
        () => isTapped.value = false,
      );
    }
  }

  void timerWrapper(VoidCallback? call){
    _tapTimer?.cancel();
    call?.call();

    _tapTimer = Timer(
      Duration(seconds: _timeSpan),
          () => isTapped.value = false,
    );
  }

  bool checkUrl(String s) {
    final uri = Uri.tryParse(s);
    return uri != null &&
        uri.hasScheme &&
        (uri.scheme == 'http' || uri.scheme == 'https');
  }

  bool isVideoEnd(VideoPlayerValue v) =>
      v.isInitialized &&
      !v.isPlaying &&
      v.position >= v.duration &&
      v.duration > Duration.zero;

  String fmt(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.inMinutes)}:${two(d.inSeconds % 60)}';
  }

  @override
  void dispose() {
    _disposed = true;

    _tapTimer?.cancel();
    _volumeStream?.cancel();

    _controller.removeListener(_videoListener);
    _controller.dispose();

    isTapped.dispose();
    isPlaying.dispose();
    isFullScreen.dispose();
    time.dispose();
    currentTime.dispose();
    currentVolume.dispose();

    super.dispose();
  }
}
