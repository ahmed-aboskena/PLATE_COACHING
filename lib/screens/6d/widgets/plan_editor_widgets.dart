import 'package:flutter/material.dart';

import '../../../widgets/coaching_widgets.dart';
import '../models/plan_exercise_model.dart';

class PlanSummaryCard extends StatelessWidget {
  const PlanSummaryCard({
    required this.exercises,
    required this.loads,
    required this.onAdjust,
    super.key,
  });

  final List<PlanExerciseModel> exercises;
  final List<double> loads;
  final void Function(int index, double delta) onAdjust;

  @override
  Widget build(BuildContext context) => UiCard(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Next week plan',
              style: TextStyle(
                color: Color(0xFF6B7886),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        for (var index = 0; index < exercises.length; index++)
          Container(
            constraints: const BoxConstraints(minHeight: 42),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFE3ECEA))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    exercises[index].name,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  tooltip: 'Decrease ${exercises[index].name}',
                  onPressed: () => onAdjust(index, -2.5),
                  icon: const Icon(Icons.remove, size: 15),
                ),
                SizedBox(
                  width: 48,
                  child: Text(
                    '${loads[index].toStringAsFixed(loads[index] % 1 == 0 ? 0 : 1)} kg',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  tooltip: 'Increase ${exercises[index].name}',
                  onPressed: () => onAdjust(index, 2.5),
                  icon: const Icon(Icons.add, size: 15),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}
