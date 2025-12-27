import 'package:brokeflix_client/core/shared/utils/async_snapshot_extensions.dart';
import 'package:brokeflix_client/core/view_models/video_player_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StackedView<VideoPlayerViewModel> {
  final _mainInputPos = 8.0;
  final _sliderPos = 8.0;
  final _titlePos = 16.0;
  final _titleWidth = 100.0;
  final _borderRadius = 25.0;
  final _backgroundColor = Colors.grey.withValues(alpha: .9);

  final VideoPlayerViewModel controller;
  VideoPlayerView({super.key, required this.controller});

  _buildFullScreenIcon(VideoPlayerViewModel vm) {
    return IconButton.outlined(
      onPressed: vm.toggleFullScreen,
      icon: ValueListenableBuilder(
        valueListenable: vm.isFullScreen,
        builder: (_, value, _) =>
            Icon(value ? Icons.fullscreen_exit : Icons.fullscreen),
      ),
    );
  }

  _buildVolumeSlider(VideoPlayerViewModel vm) {
    return ValueListenableBuilder(
      valueListenable: vm.currentVolume,
      builder: (_, value, _) => Slider(
        min: 0.0,
        max: 1.0,
        value: value,
        onChanged: vm.changeVolume,
        onChangeStart: (_) => vm.seekStart(),
        onChangeEnd: (_) => vm.seekEnd(),
      ),
    );
  }

  _buildPlayPauseButton(VideoPlayerViewModel vm) {
    return ValueListenableBuilder(
      valueListenable: vm.isPlaying,
      builder: (context, value, child) => OutlinedButton(
        onPressed: vm.togglePlaying,
        child: Icon(value ? Icons.pause : Icons.play_arrow),
      ),
    );
  }

  _buildSeekBar(VideoPlayerViewModel vm) {
    return ValueListenableBuilder(
      valueListenable: vm.currentTime,
      builder: (context, value, child) => Expanded(
        child: Row(
          children: [
            Text("${vm.fmt(value)}/${vm.fmt(vm.time.value)}"),
            Expanded(
              child: Slider(
                value: vm.getPosition,
                onChanged: vm.seekTo,
                onChangeStart: (_) => vm.seekStart(),
                onChangeEnd: (_) => vm.seekEnd(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildControls(VideoPlayerViewModel vm) {
    return [
      Positioned(
        bottom: _mainInputPos,
        left: _mainInputPos,
        right: _mainInputPos,
        child: Container(
          padding: EdgeInsets.only(left: _mainInputPos),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
            color: _backgroundColor,
          ),
          child: Row(children: [_buildSeekBar(vm), _buildFullScreenIcon(vm)]),
        ),
      ),
      Visibility(
        visible: !kIsWeb,
        child: Positioned(
          top: _sliderPos,
          right: _sliderPos,
          child: _buildVolumeSlider(vm),
        ),
      ),
      Positioned(
        top: _titlePos,
        left: _titlePos,
        width: _titleWidth,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _mainInputPos),
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
          ),
          child: Text(
            vm.title,
            maxLines: 1,
            style: TextStyle(overflow: TextOverflow.ellipsis),
          ),
        ),
      ),
      Center(child: _buildPlayPauseButton(vm)),
    ];
  }

  _buildPlayer(VideoPlayerViewModel vm) {
    return InkWell(
      onTap: () => vm.onTapOrHover(!vm.isTapped.value),
      onHover: (element) => vm.onTapOrHover(element),
      child: ValueListenableBuilder(
        valueListenable: vm.isTapped,
        builder: (_, value, _) => Stack(
          children: [
            VideoPlayer(vm.controller),
            if (value) ..._buildControls(vm),
          ],
        ),
      ),
    );
  }

  @override
  Widget builder(BuildContext context, VideoPlayerViewModel vm, Widget? _) {
    return Center(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: FutureBuilder(
          future: vm.initFuture,
          builder: (context, snapshot) => snapshot.loadSnapshot<void>(
            onLoading: () => Center(child: CircularProgressIndicator()),
            onError: (error) => Center(child: Text("Failed to load!")),
            onData: (_) => _buildPlayer(vm),
          ),
        ),
      ),
    );
  }

  @override
  VideoPlayerViewModel viewModelBuilder(BuildContext context) => controller;
}
