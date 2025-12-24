import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:brokeflix_client/ui/widgets/series_list/series_item_widget.dart';
import 'package:flutter/material.dart';

class SeriesListWidget extends StatefulWidget {
  final List<Series> seriesList;

  const SeriesListWidget({super.key, required this.seriesList});

  @override
  State<SeriesListWidget> createState() => _SeriesListWidgetState();
}

class _SeriesListWidgetState extends State<SeriesListWidget> {
  @override
  Widget build(BuildContext context) {
    final seriesList = widget.seriesList;
    return ListView.builder(
      itemCount: seriesList.length,
      itemBuilder: (context, index) =>
        SeriesItemWidget(series: seriesList[index]),
    );
  }
}
