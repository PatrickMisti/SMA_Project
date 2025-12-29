import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:brokeflix_client/core/shared/utils/interfaces.dart';
import 'package:brokeflix_client/ui/widgets/series_list/series_item_widget.dart';
import 'package:flutter/material.dart';

class SeriesListWidget extends StatefulWidget {
  final List<Series> seriesList;
  final RefreshBasis viewModel;

  const SeriesListWidget({
    super.key,
    required this.seriesList,
    required this.viewModel,
  });

  @override
  State<SeriesListWidget> createState() => _SeriesListWidgetState();
}

class _SeriesListWidgetState extends State<SeriesListWidget> {

  Future<void> refresh() async => await widget.viewModel.refreshUi();

  _buildGridSliver(List<Series> seriesList) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.7,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) =>
            SeriesItemWidget(key: ValueKey(index), series: seriesList[index]),
        childCount: seriesList.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final seriesList = widget.seriesList;
    return RefreshIndicator(
      onRefresh: refresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [

          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: _buildGridSliver(seriesList),
          ),

        ],
      ),
    );
  }
}
