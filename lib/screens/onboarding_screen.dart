import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/app_providers.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('MoodForecaster', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 12),
              const Text(
                'Förutse stress innan den känns överväldigande.\n'
                'Få personliga, dagliga micro-interventioner för bättre balans.',
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: () => ref.read(onboardingCompletedProvider.notifier).complete(),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Kom igång'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
