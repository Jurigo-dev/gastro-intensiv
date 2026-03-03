import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app_theme.dart';
import 'providers/app_providers.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } catch (_) {
    // Firebase config missing in local demo environments.
  }

  runApp(const ProviderScope(child: MoodForecasterApp()));
}

class MoodForecasterApp extends ConsumerWidget {
  const MoodForecasterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasCompletedOnboarding = ref.watch(onboardingCompletedProvider);

    return MaterialApp(
      title: 'MoodForecaster',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: hasCompletedOnboarding
          ? const HomeScreen()
          : const OnboardingScreen(),
    );
  }
}
