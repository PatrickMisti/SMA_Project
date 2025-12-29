
class SearchSeries {
  final String title;
  final String description;
  final String link;

  SearchSeries({
    required this.title,
    required this.description,
    required this.link,
  });

  factory SearchSeries.fromJson(Map<String, dynamic> json) {
    return SearchSeries(
      title: json['title'] as String,
      description: json['description'] as String,
      link: json['link'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'link': link,
    };
  }
}