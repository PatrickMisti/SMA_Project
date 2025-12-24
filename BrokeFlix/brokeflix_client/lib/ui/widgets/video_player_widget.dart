import 'package:brokeflix_client/core/shared/models/video_detail_model.dart';
import 'package:brokeflix_client/ui/views/fullscreen_video_player_view.dart';
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
  final _fullScreenLayout = 8.0;
  late VideoPlayerController _controller;
  bool _isReady = false;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() => _isReady = true);
      });
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
    _controller.pause();

    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
    setState(() {});
  }

  Future<void> _toggleFullScreen() async {
    if (_isFullScreen){
      Navigator.of(context).maybePop();
      return;
    }

    await enableFullScreen();
    setState(() => _isFullScreen = true);

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FullScreenVideoPlayerView(controller: _controller, title: widget.detail.title),
      ),
    );

    await restoreFullScreen();
    setState(() => _isFullScreen = false);
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
            InkWell(
              onTap: _togglePlay,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  if (!_controller.value.isPlaying)
                    Center(
                      child: OutlinedButton(
                        onPressed: _togglePlay,
                        child: const Icon(Icons.play_arrow),
                      ),
                    ),
                  Positioned(
                    bottom: _fullScreenLayout,
                    right: _fullScreenLayout,
                    child: IconButton(
                      onPressed: _toggleFullScreen,
                      icon: Icon(Icons.fullscreen),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) return const Center(child: CircularProgressIndicator());

    final theme = Theme.of(context);
    return Column(children: [_buildVideoPlayer(theme), _spacer(height: _defaultEdgeInsets)]);
  }
}
