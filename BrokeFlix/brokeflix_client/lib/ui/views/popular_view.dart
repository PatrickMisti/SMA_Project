import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:brokeflix_client/core/shared/utils/app_logger.dart';
import 'package:brokeflix_client/core/shared/utils/async_snapshot_extensions.dart';
import 'package:brokeflix_client/core/view_models/popular_viewmodel.dart';
import 'package:brokeflix_client/ui/widgets/series_list/series_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StartView extends StackedView<StartViewModel> {
  final logger = AppLogger.getLogger('StartView');

  StartView({super.key});

  Widget _buildSeriesList(List<Series>? seriesList, StartViewModel vm) {
    if (seriesList == null || seriesList.isEmpty) {
      return Center(child: Text('No popular series available.'));
    }

    logger.fine("Building series list with ${seriesList.length} items.");
    return SeriesListWidget(seriesList: seriesList, viewModel: vm);
  }

  @override
  Widget builder(BuildContext context, StartViewModel viewModel, _) {
    return StreamBuilder(
      stream: viewModel.popularSeriesStream.stream,
      builder: (context, snapshot) => snapshot.loadSnapshot<List<Series>>(
        onLoading: () => Center(child: CircularProgressIndicator()),
        onError: (error) => Center(child: Text('Error: $error')),
        onData: (data) => _buildSeriesList(data, viewModel),
      ),
    );
  }

  @override
  StartViewModel viewModelBuilder(BuildContext context) {
    return StartViewModel()..registerServices();
  }
}
