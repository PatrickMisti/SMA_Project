
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    // Network-URL – läuft auf Android, Web und Tizen
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://cdn-rvpuky9hp2glksoq.edgeon-bandwidth.com/engine/hls2/01/09080/jdz4bojzlipl_,n,.urlset/master.m3u8?t=aUP7tRpFfs4LfIY5n0oviGJgMRELkQhdklKvjbhvGzQ&s=1764319322&e=14400&f=66861598&node=bfinFs4uSrnmOxDmHRx4b4ZjH1INnkx85htkLPWfDV4=&i=193.170&sp=2500&asn=1853&q=n&rq=NBnqjnjqW3IibSbjrSASUZdJb7rQT0BXXDbQ3kfM'),
    )
      ..initialize().then((_) {
        setState(() => _isReady = true);
      });
  }

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Player')),
      body: Center(
        child: _isReady
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: _isReady
          ? FloatingActionButton(
        onPressed: _togglePlay,
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      )
          : null,
    );
  }
}
