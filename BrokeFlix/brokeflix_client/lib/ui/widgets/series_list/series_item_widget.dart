import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:flutter/material.dart';

class SeriesItemWidget extends StatelessWidget {
  final Series series;

  const SeriesItemWidget({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image(image: NetworkImage(series.bannerUrl)),
          Text(series.title),
        ],
      ),
    );
  }
}
