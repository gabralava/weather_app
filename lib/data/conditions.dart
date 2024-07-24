class Condition {
  final String text;
  final String icon;

  Condition({
    required this.text,
    required this.icon,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: json["text"],
        icon: json["icon"]
      );
}
