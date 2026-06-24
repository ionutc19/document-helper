class ExplainResult {
  final String summary;
  final List<String> keyPoints;
  final List<String> obligations;
  final List<String> risks;
  final List<String> actionItems;

  const ExplainResult({
    required this.summary,
    required this.keyPoints,
    required this.obligations,
    required this.risks,
    required this.actionItems,
  });

  factory ExplainResult.fromJson(Map<String, dynamic> json) {
    return ExplainResult(
      summary: json['summary'] as String? ?? '',
      keyPoints: (json['key_points'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      obligations: (json['obligations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      risks: (json['risks'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      actionItems: (json['action_items'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }
}
