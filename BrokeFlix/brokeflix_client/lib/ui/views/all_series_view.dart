import 'package:brokeflix_client/core/view_models/all_series_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AllSeriesView extends StackedView<AllSeriesViewModel> {
  const AllSeriesView({super.key});

  @override
  Widget builder(BuildContext context, AllSeriesViewModel vm, Widget? child) {
    return Column(
      children: [
        InputChip(
          label: Text("data"),
          isEnabled: true,
          selected: vm.isSelected,
          onPressed: vm.changeSelected,
          /*chipAnimationStyle: ChipAnimationStyle(
            selectAnimation: AnimationStyle(curve: Curves.fastOutSlowIn),
          ),*/
        ),
      ],
    );
  }

  @override
  AllSeriesViewModel viewModelBuilder(BuildContext context) =>
      AllSeriesViewModel();
}
