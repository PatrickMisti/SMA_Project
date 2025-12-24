
import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:flutter/material.dart';

class SeriesDetailBodyWidget extends StatefulWidget {
  final Series series;
  const SeriesDetailBodyWidget({super.key, required this.series});

  @override
  State<SeriesDetailBodyWidget> createState() => _SeriesDetailBodyWidgetState();
}

class _SeriesDetailBodyWidgetState extends State<SeriesDetailBodyWidget> {
  final double _defaultPadding = 16.0;
  final String _descriptionTitle = "Description";

  _spacer({double height = 8}) => SizedBox(height: height);

  @override
  Widget build(BuildContext context) {
    final series = widget.series;
    final ThemeData theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.all(_defaultPadding),
      child: Padding(
        padding: EdgeInsets.all(_defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(series.title, style: theme.textTheme.headlineMedium),
            _spacer(),
            ExpansionTile(
              title: Text(_descriptionTitle, style: theme.textTheme.bodyLarge),
              children: [
                Text(series.description, style: theme.textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
