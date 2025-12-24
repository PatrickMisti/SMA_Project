class Rating {
  final double value;
  final int? votes;

  Rating({required this.value, required this.votes});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      value: (json['value'] as num).toDouble(),
      votes: json['votes'],
    );
  }
}