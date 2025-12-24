import 'package:brokeflix_client/core/shared/models/episode_model.dart';
import 'package:brokeflix_client/core/view_models/series_detail_viewmodel.dart';
import 'package:flutter/material.dart';

class SeriesDetailBodyWidget extends StatefulWidget {
  final SeriesDetailViewModel viewModel;

  const SeriesDetailBodyWidget({super.key, required this.viewModel});

  Future<List<Episode>> getEpisodes(int season) async =>
      await viewModel.fetchEpisodesFromSeason(season);

  int get seasonsCount => viewModel.series.seasonsCount;
  String get title => viewModel.series.title;
  String get description => viewModel.series.description;

  @override
  State<SeriesDetailBodyWidget> createState() => _SeriesDetailBodyWidgetState();
}

class _SeriesDetailBodyWidgetState extends State<SeriesDetailBodyWidget> {
  final String _descriptionTitle = "Description";
  List<Episode> episodes = [];
  int? _selectedSeason;
  int? _selectedEpisode;


  @override
  void initState() {
    super.initState();
    _selectedSeason = 1;
    widget.getEpisodes(_selectedSeason!).then((eps) {
      episodes = eps;
      if (episodes.isNotEmpty) {
        _selectedEpisode = episodes.first.number;
      }
      setState(() {});
    });
  }

  _spacer({double height = 8}) => SizedBox(height: height);

  void changeSeason(int? season) async {
    if (season == null || _selectedSeason == season) return;
    episodes = await widget.getEpisodes(season);
    _selectedSeason = season;
    setState(() {});
  }

  void changeEpisode(int? episode) {
    if (episode == null || _selectedEpisode == episode) return;
    _selectedEpisode = episode;
    setState(() {});
  }

  DropdownMenuItem<int> _buildDropdownItem(int season) =>
      DropdownMenuItem(value: season + 1, child: Text("Season ${season + 1}"));

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final ddSeries = List.generate(widget.seasonsCount, _buildDropdownItem);
    final ddEpisodes = episodes.map((e) => e.toDropdownMenuItem()).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: theme.textTheme.headlineMedium),
        _spacer(),
        ExpansionTile(
          title: Text(_descriptionTitle, style: theme.textTheme.bodyLarge),
          children: [
            Text(widget.description, style: theme.textTheme.bodyMedium),
          ],
        ),
        _spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DropdownButton(
              value: _selectedSeason,
              items: ddSeries,
              onChanged: changeSeason,
            ),
            DropdownButton(
              value: _selectedEpisode,
              items: ddEpisodes,
              onChanged: changeEpisode,
            ),
          ],
        ),
      ],
    );
  }
}
