import 'package:brokeflix_client/core/view_models/video_player_viewmodel.dart';
import 'package:brokeflix_client/ui/views/video_player_view.dart';
import 'package:flutter/material.dart';

class FullScreenVideoPlayerWidget extends StatefulWidget {
  final VideoPlayerViewModel controller;

  const FullScreenVideoPlayerWidget({super.key, required this.controller});

  @override
  State<FullScreenVideoPlayerWidget> createState() => _FullScreenVideoPlayerWidgetState();
}

class _FullScreenVideoPlayerWidgetState extends State<FullScreenVideoPlayerWidget> {

  late VoidCallback _returning;
  @override
  void initState() {
    super.initState();
    _returning = () {
      if (!widget.controller.isFullScreen.value) {
        Navigator.pop(context);
      }
    };
    widget.controller.isFullScreen.addListener(_returning);
  }

  @override
  void dispose() {
    widget.controller.isFullScreen.removeListener(_returning);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: VideoPlayerView(controller: widget.controller),
    );
  }
}
