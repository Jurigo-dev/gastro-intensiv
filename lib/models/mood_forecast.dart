class MoodForecast {
  MoodForecast({
    required this.riskLevel,
    required this.predictedMood,
    required this.interventions,
  });

  final String riskLevel;
  final int predictedMood;
  final List<String> interventions;
}
