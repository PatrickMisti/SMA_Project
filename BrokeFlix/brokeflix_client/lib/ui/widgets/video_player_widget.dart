import 'package:brokeflix_client/core/shared/models/video_detail_model.dart';
import 'package:brokeflix_client/core/view_models/video_player_viewmodel.dart';
import 'package:brokeflix_client/ui/widgets/fullscreen_video_player_widget.dart';
import 'package:brokeflix_client/ui/views/video_player_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

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

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerViewModel(
      path: widget.videoUrl,
      title: widget.detail.title,
    );

    _controller.isFullScreen.addListener(_toggleFullScreen);
  }

  _spacer({double height = 8}) => SizedBox(height: height);

  Future enableFullScreen() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future restoreFullScreen() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() async {
    // restore defaults on dispose
    await restoreFullScreen();

    _controller.dispose();
    super.dispose();
  }

  Future<void> _toggleFullScreen() async {
    await enableFullScreen();

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FullScreenVideoPlayerView(controller: _controller),
      ),
    );
    await restoreFullScreen();
  }

  Widget _buildVideoPlayer(ThemeData theme) {
    return Card(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        _buildVideoPlayer(theme),
        _spacer(height: _defaultEdgeInsets),
      ],
    );
  }
}
