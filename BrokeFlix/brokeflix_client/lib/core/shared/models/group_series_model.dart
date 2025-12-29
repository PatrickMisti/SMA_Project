class GroupSeries {
  final String category;
  final List<String> series;

  GroupSeries({required this.category, required this.series});


  factory GroupSeries.fromJson(Map<String, dynamic> json) {
    return GroupSeries(
      category: json['category'] as String,
      series: (json['series'] as List).map((e) => e as String).toList()
    );
  }
}