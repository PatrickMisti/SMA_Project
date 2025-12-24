import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:flutter/material.dart';

class SeriesItemWidget extends StatelessWidget {
  final Series series;

  const SeriesItemWidget({super.key, required this.series});

  /*_buildTextSection() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: Text(
        series.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        softWrap: true,
        style: TextStyle(
          fontSize: 12
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Image.network(series.bannerUrl),
          ),

          /*Flexible(
            flex: 1,
            child: _buildTextSection(),
          ),*/
        ],
      ),
    );
  }
}
