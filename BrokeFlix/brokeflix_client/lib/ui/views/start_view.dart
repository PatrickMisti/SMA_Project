
import 'package:brokeflix_client/core/view_models/start_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class StartView extends StackedView<StartViewModel> {
  const StartView({super.key});

  @override
  Widget builder(
    BuildContext context,
    StartViewModel viewModel,
    Widget? child,
  ) {
    // Implement the UI for the StartView here
    return Container(child: Text("hallo"),); // Placeholder
  }

  @override
  StartViewModel viewModelBuilder(BuildContext context) {
    return StartViewModel();
  }
}