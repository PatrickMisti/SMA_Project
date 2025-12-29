import 'dart:async';

import 'package:brokeflix_client/core/shared/data_service.dart';
import 'package:brokeflix_client/core/shared/models/search_series_model.dart';
import 'package:brokeflix_client/core/shared/utils/app_logger.dart';
import 'package:brokeflix_client/ui/views/series_detail_view.dart';
import 'package:brokeflix_client/ui/widgets/webview_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';

class SearchSeriesViewModel extends BaseViewModel {
  final _logger = AppLogger.getLogger("SearchSeriesViewModel");
  final DataService _dataService;

  final TextEditingController searchFieldController;
  late final VoidCallback _textChanged;
  Timer? _debounce;
  final _debounceTime = 500;

  SearchSeriesViewModel()
    : searchFieldController = TextEditingController(),
      _dataService = GetIt.I.get<DataService>() {
    _textChanged = _onTextChanged;
  }

  BehaviorSubject<List<SearchSeries>?> get searchSeriesStream =>
      _dataService.searchSeriesStream;

  void register() {
    searchFieldController.addListener(_textChanged);
  }

  void _onTextChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(Duration(milliseconds: _debounceTime), () async {
      final text = searchFieldController.text.trim();
      _logger.fine("Search for $text");
      await _dataService.fetchSearchSeries(text);
    });
  }

  @override
  void dispose() {
    searchFieldController.removeListener(_textChanged);
    _debounce?.cancel();
    searchFieldController.dispose();
    super.dispose();
  }

  void getDetailPage(SearchSeries data, BuildContext ctx) {
    final series = _dataService.fetchSeriesOnTitle(data.title);

    series.then((value) {
      if (!ctx.mounted) return;

      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (context) => value != null
              ? SeriesDetailView(series: value)
              : WebViewPageWidget(title: data.title, url: data.link),
        ),
      );
    });
  }
}
