import 'package:brokeflix_client/core/shared/models/series_model.dart';
import 'package:brokeflix_client/ui/views/series_detail_view.dart';
import 'package:flutter/material.dart';

class SeriesItemWidget extends StatelessWidget {
  final Series series;
  final String heroTagPrefix = "series_detail_";

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
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SeriesDetailView(series: series)),
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Hero(
                tag: heroTagPrefix + series.bannerUrl,
                child: Image.network(series.bannerUrl),
              ),
            ),

            /*Flexible(
            flex: 1,
            child: _buildTextSection(),
          ),*/
          ],
        ),
      ),
    );
  }
}
