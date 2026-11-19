import 'package:flutter/material.dart';

import '../../../widgets/coaching_widgets.dart';

class PlanSummaryStat extends StatelessWidget {
  const PlanSummaryStat({required this.value, required this.label, super.key});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Expanded(
    child: UiCard(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Text(
            label,
            style: const TextStyle(color: Color(0xFF6B7886), fontSize: 8),
          ),
        ],
      ),
    ),
  );
}
