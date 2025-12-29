import 'package:brokeflix_client/core/shared/models/group_series_model.dart';
import 'package:brokeflix_client/core/shared/utils/async_snapshot_extensions.dart';
import 'package:brokeflix_client/core/view_models/all_series_viewmodel.dart';
import 'package:brokeflix_client/ui/widgets/series_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AllSeriesView extends StackedView<AllSeriesViewModel> {
  final _errorMessage = "Reload";


  const AllSeriesView({super.key});

  _buildAppBar(AllSeriesViewModel vm, List<GroupSeries>? data) {
    if (data == null) return;
    return SliverAppBar(
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: SeriesFilterWidget(
          groupList: data,
          isSelected: vm.checkChipSelected,
          changeSelection: vm.selectCategories,
        ),
      ),
    );
  }

  _buildBody(AllSeriesViewModel vm) {
    return ValueListenableBuilder(
      valueListenable: vm.selectedCategories,
      builder: (context, value, child) {
        final data = vm.getListOfCategories;

        return SliverList.list(
          children: List.of(data).map((e) => ListTile(title: Text(e))).toList(),
        );
      }
    );
  }

  @override
  Widget builder(BuildContext context, AllSeriesViewModel vm, Widget? child) {
    return RefreshIndicator(
      onRefresh: vm.refreshUi,
      child: StreamBuilder(
        stream: vm.allGroupedSeries,
        builder: (context, snapshot) =>
            snapshot.loadSnapshot<List<GroupSeries>>(
              onLoading: () => Center(child: CircularProgressIndicator()),
              onError: (e) => Center(child: Text(_errorMessage)),
              onData: (data) => Scrollbar(
                controller: vm.scrollController,
                child: CustomScrollView(
                  slivers: [_buildAppBar(vm, data), _buildBody(vm)],
                ),
              ),
            ),
      ),
    );
  }

  @override
  AllSeriesViewModel viewModelBuilder(BuildContext context) =>
      AllSeriesViewModel()..registerService();
}
