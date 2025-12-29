import 'package:brokeflix_client/core/shared/models/search_series_model.dart';
import 'package:brokeflix_client/core/shared/utils/async_snapshot_extensions.dart';
import 'package:brokeflix_client/core/view_models/search_series_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SearchSeriesView extends StackedView<SearchSeriesViewModel> {
  final _searchPlaceholder = "Suche";
  final _errorText = "Kann keine Serien finden!";
  final _searchFieldPadding = 16.0;

  const SearchSeriesView({super.key});

  @override
  Widget builder(BuildContext context, SearchSeriesViewModel vm, Widget? _) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsetsGeometry.all(_searchFieldPadding),
          sliver: SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: TextField(
                controller: vm.searchFieldController,
                decoration: InputDecoration(labelText: _searchPlaceholder),
              ),
            ),
          ),
        ),

        StreamBuilder(
          stream: vm.searchSeriesStream,
          builder: (context, snapshot) =>
              snapshot.loadSnapshot<List<SearchSeries>>(
                onLoading: () => SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
                onError: (error) =>
                    SliverToBoxAdapter(child: Center(child: Text(_errorText))),
                onEmpty: () =>
                    SliverToBoxAdapter(child: Center(child: Text(_errorText))),
                onData: (data) => SliverList.builder(
                  itemBuilder: (context, index) =>
                      ListTile(
                        onTap: () => vm.getDetailPage(data[index], context),
                          title: Text(data![index].title)),
                ),
              ),
        ),
      ],
    );
  }

  @override
  SearchSeriesViewModel viewModelBuilder(BuildContext context) =>
      SearchSeriesViewModel()..register();
}
