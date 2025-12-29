
import 'package:brokeflix_client/core/view_models/dashboard_viewmodel.dart';
import 'package:brokeflix_client/ui/views/all_series_view.dart';
import 'package:brokeflix_client/ui/views/popular_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StackedView<DashboardViewModel> {
  final _title = "Brokeflix";
  final _newSiteTitle = "Neue";
  final _searchTitle = "Suche";
  final _allTitle = "Alle";

  const DashboardView({super.key});

  @override
  Widget builder(
    BuildContext context,
    DashboardViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: PageView(
        controller: viewModel.pageController,

        onPageChanged: viewModel.updateCurrentIndex,
        children: [
          PopularView(),
          AllSeriesView(),
          Center(child: Text('Dashboard View ${viewModel.currentIndex}')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: viewModel.currentIndex,
        onTap: viewModel.updateCurrentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: _newSiteTitle),
          BottomNavigationBarItem(icon: Icon(Icons.all_inclusive), label: _allTitle),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: _searchTitle),
        ],
      ),
    );
  }

  @override
  void onViewModelReady(DashboardViewModel viewModel) {
    // viewModel.updateCurrentIndex(viewModel.currentIndex);
    super.onViewModelReady(viewModel);
    debugPrint("hallo");
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) {
    return DashboardViewModel();
  }
}
