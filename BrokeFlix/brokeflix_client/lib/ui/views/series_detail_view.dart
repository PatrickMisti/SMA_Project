import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:brokeflix_client/core/shared/utils/async_snapshot_extensions.dart';
import 'package:brokeflix_client/core/view_models/series_detail_viewmodel.dart';
import 'package:brokeflix_client/ui/widgets/series_detail_body_widget.dart';
import 'package:brokeflix_client/ui/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SeriesDetailView extends StackedView<SeriesDetailViewModel> {
  final Series series;
  final _sliverAppBarHeight = 250.0;
  final _defaultEdgeInsets = 16.0;
  final _errorMessage = "Failed to load video stream.";

  const SeriesDetailView({super.key, required this.series});

  _buildSliverAppBar(SeriesDetailViewModel vm) {
    return SliverAppBar(
      expandedHeight: _sliverAppBarHeight,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        // title: Text(series.title),
        background: Hero(
          tag: vm.heroTag,
          child: Image.network(series.bannerUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }

  @override
  Widget builder(BuildContext context, SeriesDetailViewModel vm, Widget? _) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(vm),
          SliverToBoxAdapter(
            child: Card(
              margin: EdgeInsets.all(_defaultEdgeInsets),
              child: Padding(
                padding: EdgeInsets.all(_defaultEdgeInsets),
                child: SeriesDetailBodyWidget(viewModel: vm),
              ),
            ),
          ),
          if (vm.selectedHoster != null && vm.selectedEpisode != null)
            SliverToBoxAdapter(
              child: FutureBuilder(
                future: vm.loadVideoUrl(),
                builder: (context, snapshot) => snapshot.loadSnapshot<String>(
                  onLoading: () => Center(child: CircularProgressIndicator()),
                  onError: (_) => Center(child: Text(_errorMessage)),
                  onEmpty: () => Center(child: Text(_errorMessage)),
                  onData: (v) => VideoPlayerWidget(videoUrl: v!, detail: vm.selectedEpisode!),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  SeriesDetailViewModel viewModelBuilder(BuildContext context) =>
      SeriesDetailViewModel(series: series);
}
