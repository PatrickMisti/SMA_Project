import 'package:brokeflix_client/core/view_models/video_player_viewmodel.dart';
import 'package:brokeflix_client/ui/views/video_player_view.dart';
import 'package:flutter/material.dart';

class FullScreenVideoPlayerView extends StatelessWidget {
  final VideoPlayerViewModel controller;

  const FullScreenVideoPlayerView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: VideoPlayerView(controller: controller)),
    );
  }
}
