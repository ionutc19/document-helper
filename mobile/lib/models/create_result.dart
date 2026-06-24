class CreateResult {
  final String generatedText;
  final String outputType;

  const CreateResult({
    required this.generatedText,
    required this.outputType,
  });

  factory CreateResult.fromJson(Map<String, dynamic> json) {
    return CreateResult(
      generatedText: json['generated_text'] as String? ?? '',
      outputType: json['output_type'] as String? ?? '',
    );
  }
}
