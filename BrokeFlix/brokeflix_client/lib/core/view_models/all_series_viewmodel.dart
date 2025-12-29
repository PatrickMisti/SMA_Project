
import 'package:brokeflix_client/core/shared/data_service.dart';
import 'package:brokeflix_client/core/shared/models/group_series_model.dart';
import 'package:brokeflix_client/core/shared/utils/app_logger.dart';
import 'package:brokeflix_client/core/shared/utils/interfaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';

class AllSeriesViewModel extends BaseViewModel implements RefreshBasis {
  final DataService _dataService;
  final _logger = AppLogger.getLogger("AllSeriesViewModel");

  final ScrollController scrollController = ScrollController();
  final selectedCategories = ValueNotifier<List<String>>([]);

  AllSeriesViewModel() : _dataService = GetIt.I.get<DataService>();

  BehaviorSubject<List<GroupSeries>> get allGroupedSeries =>
      _dataService.allGroupSeriesStream;

  List<String> get getCategories => allGroupedSeries.value.map((e) => e.category).toList();

  Iterable<String> get getListOfCategories {
    final elements = allGroupedSeries.value;
    if (selectedCategories.value.isEmpty) return elements.expand((e) => e.series);

    final data =  elements
        .where((e) => selectedCategories.value.contains(e.category));

    if (data.isEmpty) return elements.expand((e) => e.series);

    return data.expand((e) => e.series);
  }

  void registerService() {
    if (allGroupedSeries.valueOrNull == null) {
      _logger.fine("Fetching all series for the first time.");
      _dataService.fetchAllGroupSeries();
    }
  }

  void selectCategories(String category) {
    if (selectedCategories.value.contains(category)) {
      selectedCategories.value.remove(category);
    }
    else {
      selectedCategories.value.add(category);
    }
    _logger.info("selected categories: $selectedCategories");
  }

  bool checkChipSelected(String e) => selectedCategories.value.contains(e);

  @override
  Future<void> refreshUi() async {
    _logger.info("Refresh all group service!");
    await _dataService.fetchAllGroupSeries();
  }
}