
import 'package:brokeflix_client/core/view_models/dashboard_viewmodel.dart';
import 'package:brokeflix_client/ui/views/start_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StackedView<DashboardViewModel> {
  final _title = "Brokeflix";

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
          StartView(),
          Center(child: Text('Dashboard View ${viewModel.currentIndex}')),
          Center(child: Text('Dashboard View ${viewModel.currentIndex}')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: viewModel.currentIndex,
        onTap: viewModel.updateCurrentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) {
    return DashboardViewModel();
  }
}
