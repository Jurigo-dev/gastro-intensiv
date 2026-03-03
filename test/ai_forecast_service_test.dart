import 'package:flutter_test/flutter_test.dart';
import 'package:mood_forecaster/models/mood_entry.dart';
import 'package:mood_forecaster/services/ai_forecast_service.dart';

void main() {
  test('returns high risk for high stress and low mood', () {
    final service = AiForecastService();
    final entries = [
      MoodEntry(
        id: '1',
        timestamp: DateTime(2026, 1, 1),
        moodScore: 3,
        energyScore: 2,
        stressScore: 9,
        note: 'Stressad',
        steps: 1000,
        sleepHours: 5,
      ),
    ];

    final result = service.forecast(entries);

    expect(result.riskLevel, 'Hög');
    expect(result.predictedMood, lessThanOrEqualTo(4));
  });
}
