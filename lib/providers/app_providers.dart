import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/mood_entry.dart';
import '../models/mood_forecast.dart';
import '../repositories/mood_repository.dart';
import '../services/ai_forecast_service.dart';
import '../services/local_db_service.dart';
import '../services/subscription_service.dart';

final localDbServiceProvider = Provider((_) => LocalDbService());
final moodRepositoryProvider = Provider(
  (ref) => MoodRepository(ref.read(localDbServiceProvider)),
);
final aiServiceProvider = Provider((_) => AiForecastService());
final subscriptionServiceProvider = Provider((_) => SubscriptionService());

final onboardingCompletedProvider = StateNotifierProvider<OnboardingNotifier, bool>(
  (ref) => OnboardingNotifier(),
);

class OnboardingNotifier extends StateNotifier<bool> {
  OnboardingNotifier() : super(false) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('onboarding_done') ?? false;
  }

  Future<void> complete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    state = true;
  }
}

final moodEntriesProvider = FutureProvider<List<MoodEntry>>((ref) async {
  return ref.read(moodRepositoryProvider).getEntries();
});

final moodForecastProvider = Provider<MoodForecast>((ref) {
  final entriesAsync = ref.watch(moodEntriesProvider);
  final entries = entriesAsync.value ?? _demoEntries();
  return ref.read(aiServiceProvider).forecast(entries);
});

List<MoodEntry> _demoEntries() {
  final now = DateTime.now();
  final random = Random(42);
  return List.generate(
    7,
    (index) => MoodEntry(
      id: 'demo-$index',
      timestamp: now.subtract(Duration(days: index)),
      moodScore: 4 + random.nextInt(5),
      energyScore: 3 + random.nextInt(6),
      stressScore: 3 + random.nextInt(5),
      note: 'Demoanteckning dag ${index + 1}',
      steps: 3500 + random.nextInt(6000),
      sleepHours: 5.5 + random.nextDouble() * 3,
    ),
  );
}
