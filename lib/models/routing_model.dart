class RoutingResult {
  final String prompt;
  final String selectedModel;
  final double confidence;
  final String reason;
  final DateTime timestamp;

  RoutingResult({
    required this.prompt,
    required this.selectedModel,
    required this.confidence,
    required this.reason,
    required this.timestamp,
  });
}

class AIModel {
  final String name;
  final String provider;
  final double qualityScore;
  final double speedScore;
  final double costScore;
  final bool isAvailable;

  AIModel({
    required this.name,
    required this.provider,
    required this.qualityScore,
    required this.speedScore,
    required this.costScore,
    required this.isAvailable,
  });
}
