import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mood_entry.dart';
import '../providers/app_providers.dart';
import '../widgets/mood_score_slider.dart';

class LogMoodScreen extends ConsumerStatefulWidget {
  const LogMoodScreen({super.key});

  @override
  ConsumerState<LogMoodScreen> createState() => _LogMoodScreenState();
}

class _LogMoodScreenState extends ConsumerState<LogMoodScreen> {
  double _mood = 6;
  double _energy = 6;
  double _stress = 5;
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final entry = MoodEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      timestamp: DateTime.now(),
      moodScore: _mood.round(),
      energyScore: _energy.round(),
      stressScore: _stress.round(),
      note: _noteController.text.trim(),
      steps: 5000,
      sleepHours: 7.0,
    );

    await ref.read(moodRepositoryProvider).saveEntry(entry);
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logga dagsform')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          MoodScoreSlider(label: 'Humör', value: _mood, onChanged: (v) => setState(() => _mood = v)),
          MoodScoreSlider(label: 'Energi', value: _energy, onChanged: (v) => setState(() => _energy = v)),
          MoodScoreSlider(label: 'Stress', value: _stress, onChanged: (v) => setState(() => _stress = v)),
          TextField(
            controller: _noteController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Reflektion (valfritt)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save),
            label: const Text('Spara'),
          ),
        ],
      ),
    );
  }
}
