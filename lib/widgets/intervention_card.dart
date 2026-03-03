import 'package:flutter/material.dart';

class InterventionCard extends StatelessWidget {
  const InterventionCard({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.self_improvement),
        title: Text(text),
      ),
    );
  }
}
