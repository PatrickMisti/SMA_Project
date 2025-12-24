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
              if (vm.showControls)
                Positioned(
                  bottom: _exitFullScreenLayout,
                  right: _exitFullScreenLayout,
                  child: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.fullscreen_exit),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              if (vm.showControls)
                Center(
                  child: IconButton(
                    iconSize: 64,
                    color: Colors.white70,
                    icon: Icon(controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: vm.togglePlay,
                  ),
                ),
              if (vm.showControls)
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
