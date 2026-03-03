import '../models/mood_entry.dart';
import '../models/mood_forecast.dart';

class AiForecastService {
  MoodForecast forecast(List<MoodEntry> entries) {
    if (entries.isEmpty) {
      return MoodForecast(
        riskLevel: 'Låg',
        predictedMood: 7,
        interventions: const [
          'Starta med en 2-minuters andningsövning.',
          'Skriv en kort tacksamhetsnotering.',
        ],
      );
    }

    final recent = entries.take(7).toList();
    final avgMood = recent.map((e) => e.moodScore).reduce((a, b) => a + b) / recent.length;
    final avgStress = recent.map((e) => e.stressScore).reduce((a, b) => a + b) / recent.length;
    final avgSleep = recent.map((e) => e.sleepHours).reduce((a, b) => a + b) / recent.length;

    final predictedMood = (avgMood - (avgStress * 0.25) + (avgSleep * 0.2)).clamp(1, 10).round();
    final riskLevel = predictedMood <= 4
        ? 'Hög'
        : predictedMood <= 6
            ? 'Medel'
            : 'Låg';

    final interventions = <String>[
      if (avgSleep < 7) 'Planera en sömnrutin med 30 min tidigare läggtid.',
      if (avgStress > 6) 'Ta en 5-min promenad och gör 4-7-8-andning.',
      'Gör en kort reflektion: vad gav energi idag?',
    ];

    return MoodForecast(
      riskLevel: riskLevel,
      predictedMood: predictedMood,
      interventions: interventions,
    );
  }
}
