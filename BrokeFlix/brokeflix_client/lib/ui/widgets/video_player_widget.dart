import 'package:brokeflix_client/core/shared/models/video_detail_model.dart';
import 'package:brokeflix_client/core/view_models/video_player_viewmodel.dart';
import 'package:brokeflix_client/ui/widgets/fullscreen_video_player_widget.dart';
import 'package:brokeflix_client/ui/views/video_player_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final VideoDetail detail;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    required this.detail,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  final _defaultEdgeInsets = 16.0;
  late VideoPlayerViewModel _controller;
  late final VoidCallback _fullScreenListener;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerViewModel(
      path: widget.videoUrl,
      title: widget.detail.title,
    );

    _fullScreenListener = () {
      if (!mounted) return;
      _toggleFullscreen();
    };

    _controller.isFullScreen.addListener(_fullScreenListener);
  }

  void _toggleFullscreen() {
    if (_controller.isFullScreen.value) {
      enableFullScreen();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => FullScreenVideoPlayerWidget(controller: _controller),
        ),
      );
    } else {
      restoreFullScreen();
    }
  }

  _spacer({double height = 8}) => SizedBox(height: height);

  enableFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  restoreFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    // restore defaults on dispose
    restoreFullScreen();
    _controller.isFullScreen.removeListener(_fullScreenListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Card(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.all(_defaultEdgeInsets),
          child: Padding(
            padding: EdgeInsets.all(_defaultEdgeInsets),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.detail.title,
                  style: theme.textTheme.headlineMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                _spacer(),
                VideoPlayerView(controller: _controller)
              ],
            ),
          ),
        ),
        _spacer(height: _defaultEdgeInsets),
      ],
    );
  }
}
