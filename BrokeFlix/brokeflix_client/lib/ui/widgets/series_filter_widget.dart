import 'package:brokeflix_client/core/shared/models/group_series_model.dart';
import 'package:flutter/material.dart';

typedef IsSelected = bool Function(String element);
typedef ChangeSelection = void Function(String element);

class SeriesFilterWidget extends StatefulWidget {
  final List<GroupSeries> groupList;
  final IsSelected isSelected;
  final ChangeSelection changeSelection;

  const SeriesFilterWidget({
    super.key,
    required this.groupList,
    required this.isSelected,
    required this.changeSelection,
  });

  @override
  State<SeriesFilterWidget> createState() => _SeriesFilterWidgetState();
}

class _SeriesFilterWidgetState extends State<SeriesFilterWidget> {
  final _inputChipGap = 10.0;

  @override
  Widget build(BuildContext context) {
    final data = widget.groupList;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _inputChipGap),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: _inputChipGap,
          children: List.generate(data.length, (index) {
            final e = data[index].category;
            return InputChip(
              selected: widget.isSelected(e),
              label: Text(e),
              onPressed: () => setState(() => widget.changeSelection(e)),
            );
          }),
        ),
      ),
    );
  }
}
