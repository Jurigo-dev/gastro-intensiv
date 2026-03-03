import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/app_providers.dart';
import '../services/subscription_service.dart';
import '../widgets/intervention_card.dart';
import 'log_mood_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _premium = false;

  @override
  void initState() {
    super.initState();
    _initSubscription();
  }

  Future<void> _initSubscription() async {
    final service = ref.read(subscriptionServiceProvider);
    await service.configure();
    final enabled = await service.hasPremiumAccess();
    if (mounted) setState(() => _premium = enabled);
  }

  @override
  Widget build(BuildContext context) {
    final forecast = ref.watch(moodForecastProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MoodForecaster'),
        actions: [
          if (!_premium)
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Chip(label: Text('Free')),
            )
          else
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Chip(label: Text('Premium')),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LogMoodScreen()),
        ).then((_) => ref.invalidate(moodEntriesProvider)),
        icon: const Icon(Icons.add),
        label: const Text('Logga humör'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text('Prediktion för nästa 24h'),
              subtitle: Text('Risknivå: ${forecast.riskLevel} • Predikterat humör: ${forecast.predictedMood}/10'),
            ),
          ),
          const SizedBox(height: 8),
          Text('Föreslagna interventioner', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...forecast.interventions.map((tip) => InterventionCard(text: tip)),
          const SizedBox(height: 12),
          if (_premium)
            const Card(
              child: ListTile(
                leading: Icon(Icons.auto_awesome),
                title: Text('Premium Insight'),
                subtitle: Text('Din stressrisk är 18% lägre jämfört med förra veckan.'),
              ),
            )
          else
            Card(
              child: ListTile(
                leading: const Icon(Icons.workspace_premium),
                title: const Text('Lås upp premium för avancerade AI-insikter'),
                subtitle: const Text('49 kr/mån via RevenueCat'),
                trailing: FilledButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Integrera paywall i nästa steg.')),
                    );
                  },
                  child: const Text('Uppgradera'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
