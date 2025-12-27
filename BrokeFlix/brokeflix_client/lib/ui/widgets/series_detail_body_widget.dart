import 'package:brokeflix_client/core/shared/models/episode_model.dart';
import 'package:brokeflix_client/core/shared/utils/hoster_ext.dart';
import 'package:brokeflix_client/core/view_models/series_detail_viewmodel.dart';
import 'package:flutter/material.dart';

class SeriesDetailBodyWidget extends StatefulWidget {
  final SeriesDetailViewModel viewModel;

  const SeriesDetailBodyWidget({super.key, required this.viewModel});

  Future<List<Episode>> getEpisodes(int season) async =>
      await viewModel.fetchEpisodesFromSeason(season);

  void updateSelectedEpisodeAndHoster(int season, int episode, String hoster) =>
      viewModel.updateSelectedEpisodeAndHoster(season, episode, hoster);

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
  String? _selectedHoster;

  @override
  void initState() {
    super.initState();
    _selectedSeason = 1;
    widget.getEpisodes(_selectedSeason!).then((eps) {
      episodes = eps;
      if (episodes.isNotEmpty) {
        _selectedEpisode = episodes.first.number;
        _selectedHoster = episodes.first.hosters.first.displayName;

        if (_selectedHoster != null && _selectedEpisode != null) {
          notifySelectedEpisodeAndHoster();
        }
      }
      setState(() {});
    });
  }

  _spacer({double height = 8}) => SizedBox(height: height);

  void notifySelectedEpisodeAndHoster() {
    if (_selectedEpisode != null &&
        _selectedHoster != null &&
        _selectedSeason != null) {
      widget.updateSelectedEpisodeAndHoster(
        _selectedSeason!,
        _selectedEpisode!,
        _selectedHoster!,
      );
    }
  }

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
    notifySelectedEpisodeAndHoster();
  }

  void changeHoster(String? hoster) {
    if (hoster == null || _selectedHoster == hoster) return;
    _selectedHoster = hoster;
    setState(() {});
    notifySelectedEpisodeAndHoster();
  }

  DropdownMenuItem<int> _buildDropdownItem(int season) =>
      DropdownMenuItem(value: season + 1, child: Text("Season ${season + 1}"));

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final ddSeries = List.generate(widget.seasonsCount, _buildDropdownItem);
    final ddEpisodes = episodes.map((e) => e.toDropdownMenuItem(fullTitle: false)).toList();
    final ddEpisodesFull = episodes.map((e) => e.toDropdownMenuItem()).toList();

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
              items: ddEpisodesFull,
              onChanged: changeEpisode,
              selectedItemBuilder: (context) => ddEpisodes,
            ),
            DropdownButton<String>(
              value: _selectedHoster,
              items: _selectedEpisode == null
                  ? []
                  : episodes[_selectedEpisode! - 1].toHosterMenuItem(),
              onChanged: changeHoster,
            ),
          ],
        ),
      ],
    );
  }
}
