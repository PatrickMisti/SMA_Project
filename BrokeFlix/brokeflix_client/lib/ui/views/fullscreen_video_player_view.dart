import 'package:brokeflix_client/core/view_models/fullscreen_video_player_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPlayerView extends StackedView<FullscreenVideoPlayerViewModel> {
  final VideoPlayerController controller;
  final String title;

  final _exitFullScreenLayout = 8.0;
  final _titleLayout = 16.0;

  const FullScreenVideoPlayerView({
    super.key,
    required this.controller,
    required this.title,
  });

  _buildVideoPlayer() {
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller),
    );
  }

  _showControls(FullscreenVideoPlayerViewModel vm, BuildContext ctx) {
    if (!vm.showControls) [];

    final maxMs = vm.duration.inMilliseconds > 0 ? vm.duration.inMilliseconds.toDouble() : 1.0;
    final posMs = vm.position.inMilliseconds.toDouble().clamp(0.0, maxMs);

    return [
      Positioned(
        bottom: _exitFullScreenLayout,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Slider(value: posMs, min: 0, max: maxMs, onChanged: vm.duration > Duration.zero ? (value) => vm.seekTo(value) : null),
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.fullscreen_exit),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        )
      ),
      Center(
        child: IconButton(
          iconSize: 64,
          color: Colors.white70,
          icon: Icon(controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: vm.togglePlay,
        ),
      ),
      Positioned(
        top: _titleLayout,
        left: _titleLayout,
        right: _titleLayout,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ];
  }

  @override
  Widget builder(BuildContext context, FullscreenVideoPlayerViewModel vm, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: vm.toggleShowControls,
          child: Stack(
            children: [
              _buildVideoPlayer(),
              ..._showControls(vm, context),
            ],
          ),
        ),
      ),
    );
  }

  @override
  FullscreenVideoPlayerViewModel viewModelBuilder(BuildContext context) =>
      FullscreenVideoPlayerViewModel(controller: controller);
}
