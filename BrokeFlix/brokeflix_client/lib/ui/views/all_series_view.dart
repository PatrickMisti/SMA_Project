import 'package:brokeflix_client/core/shared/models/group_series_model.dart';
import 'package:brokeflix_client/core/shared/utils/async_snapshot_extensions.dart';
import 'package:brokeflix_client/core/view_models/all_series_viewmodel.dart';
import 'package:brokeflix_client/ui/views/series_detail_view.dart';
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
    return StreamBuilder(
      stream: vm.selectedGroups,
      builder: (context, snapshot) => snapshot.loadSnapshot<List<String>>(
        onLoading: () => SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()),
        ),
        onError: (e) =>
            SliverToBoxAdapter(child: Center(child: Text(_errorMessage))),
        onData: (d) {
          if (d == null) {
            return SliverToBoxAdapter(
              child: Center(child: Text(_errorMessage)),
            );
          }

          return SliverList.list(
            children: d
                .map(
                  (e) => ListTile(
                    onTap: () => vm.onTapSelected(e, context),
                    title: Text(e),
                  ),
                )
                .toList(),
          );
        },
      ),
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
                interactive: true,
                controller: vm.scrollController,
                child: CustomScrollView(
                  controller: vm.scrollController,
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
