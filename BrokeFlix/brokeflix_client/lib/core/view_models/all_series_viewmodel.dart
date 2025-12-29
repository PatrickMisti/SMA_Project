import 'dart:async';

import 'package:brokeflix_client/core/shared/data_service.dart';
import 'package:brokeflix_client/core/shared/models/group_series_model.dart';
import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:brokeflix_client/core/shared/utils/app_logger.dart';
import 'package:brokeflix_client/core/shared/utils/interfaces.dart';
import 'package:brokeflix_client/ui/views/series_detail_view.dart';
import 'package:brokeflix_client/ui/widgets/error_screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';

class AllSeriesViewModel extends BaseViewModel implements RefreshBasis {
  final DataService _dataService;
  final _logger = AppLogger.getLogger("AllSeriesViewModel");

  final _errorPageTitle =
      "Kann die Serie nicht laden! Versuchen Sie eine andere!";

  BehaviorSubject<List<String>> selectedGroups;
  StreamSubscription? _subscription;

  final ScrollController scrollController = ScrollController();
  final selectedCategories = ValueNotifier<List<String>>([]);

  AllSeriesViewModel()
    : _dataService = GetIt.I.get<DataService>(),
      selectedGroups = BehaviorSubject.seeded([]);

  BehaviorSubject<List<GroupSeries>> get allGroupedSeries =>
      _dataService.allGroupSeriesStream;

  List<String> get getCategories =>
      allGroupedSeries.value.map((e) => e.category).toList();

  void registerService() {
    if (allGroupedSeries.valueOrNull == null) {
      _logger.fine("Fetching all series for the first time.");
      _dataService.fetchAllGroupSeries();
    }
    _subscription = allGroupedSeries.listen((value) => categoryChanged());
  }

  void selectCategories(String category) {
    if (selectedCategories.value.contains(category)) {
      selectedCategories.value.remove(category);
    } else {
      selectedCategories.value.add(category);
    }
    _logger.info("selected categories: $selectedCategories");
    categoryChanged();
  }

  void categoryChanged() {
    if (!allGroupedSeries.hasValue) return;

    final elements = allGroupedSeries.value;
    if (selectedCategories.value.isEmpty) {
      return selectedGroups.add(elements.expand((e) => e.series).toList());
    }

    final data = elements.where(
      (e) => selectedCategories.value.contains(e.category),
    );

    if (data.isEmpty) {
      return selectedGroups.add(elements.expand((e) => e.series).toList());
    }

    return selectedGroups.add(data.expand((e) => e.series).toList());
  }

  void onTapSelected(String title, BuildContext context) {
    final seriesTask = getSeriesFromTitle(title);

    seriesTask
        .then((e) {
          if (!context.mounted) return;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => e == null
                  ? ErrorScreenWidget(errorText: _errorPageTitle)
                  : SeriesDetailView(series: e),
            ),
          );
        });
  }

  bool checkChipSelected(String e) => selectedCategories.value.contains(e);

  String heroTag(Series series) => "series_detail_${series.bannerUrl}";

  Future<Series?> getSeriesFromTitle(String title) =>
      _dataService.fetchSeriesOnTitle(title);

  @override
  Future<void> refreshUi() async {
    _logger.info("Refresh all group service!");
    await _dataService.fetchAllGroupSeries();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    selectedGroups.close();
    selectedCategories.dispose();
    super.dispose();
  }
}
