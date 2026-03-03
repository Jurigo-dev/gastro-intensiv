class MoodEntry {
  MoodEntry({
    required this.id,
    required this.timestamp,
    required this.moodScore,
    required this.energyScore,
    required this.stressScore,
    required this.note,
    required this.steps,
    required this.sleepHours,
  });

  final String id;
  final DateTime timestamp;
  final int moodScore;
  final int energyScore;
  final int stressScore;
  final String note;
  final int steps;
  final double sleepHours;

  Map<String, dynamic> toMap() => {
        'id': id,
        'timestamp': timestamp.toIso8601String(),
        'moodScore': moodScore,
        'energyScore': energyScore,
        'stressScore': stressScore,
        'note': note,
        'steps': steps,
        'sleepHours': sleepHours,
      };

  factory MoodEntry.fromMap(Map<String, dynamic> map) => MoodEntry(
        id: map['id'] as String,
        timestamp: DateTime.parse(map['timestamp'] as String),
        moodScore: map['moodScore'] as int,
        energyScore: map['energyScore'] as int,
        stressScore: map['stressScore'] as int,
        note: map['note'] as String,
        steps: map['steps'] as int,
        sleepHours: (map['sleepHours'] as num).toDouble(),
      );
}
