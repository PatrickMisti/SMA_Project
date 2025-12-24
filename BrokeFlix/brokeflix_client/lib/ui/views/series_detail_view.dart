import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:brokeflix_client/core/view_models/series_detail_viewmodel.dart';
import 'package:brokeflix_client/ui/widgets/series_detail_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SeriesDetailView extends StackedView<SeriesDetailViewModel> {
  final Series series;
  final sliverAppBarHeight = 250.0;

  const SeriesDetailView({super.key, required this.series});

  _buildSliverAppBar(SeriesDetailViewModel vm) {
    return SliverAppBar(
      expandedHeight: sliverAppBarHeight,
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
          SliverToBoxAdapter(child: SeriesDetailBodyWidget(series: series)),
        ],
      ),
    );
  }

  @override
  SeriesDetailViewModel viewModelBuilder(BuildContext context) =>
      SeriesDetailViewModel(series);
}
