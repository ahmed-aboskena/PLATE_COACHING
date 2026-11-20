import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../state/coaching_scope.dart';
import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';
import '../2d/models/workout_model.dart';
import '../2d/widgets/member_training_widgets.dart';

class CoachTrainScreen extends StatelessWidget {
  const CoachTrainScreen({this.large = false, super.key});

  final bool large;

  @override
  Widget build(BuildContext context) => PhoneMockup(
    screenId: 'coach-train',
    title: 'My training',
    large: large,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ScreenHeading(
          'My training',
          eyebrow: 'Personal workout',
          trailing: StatusPill('COACH'),
        ),
        const UiCard(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal plan',
                    style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
                  ),
                  Text(
                    'Active',
                    style: TextStyle(
                      color: Color(0xFF1F9A85),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'This week',
                      style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
                    ),
                    Text(
                      '3 workouts',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const WorkoutCard(
          WorkoutModel(
            day: 'Mon',
            title: 'Push · Chest & shoulders',
            detail: '55 min · Completed',
            done: true,
          ),
        ),
        const _ExerciseWeightCard('Bench Press'),
        const _ExerciseWeightCard('Shoulder Press'),
        const WorkoutCard(
          WorkoutModel(
            day: 'Wed',
            title: 'Pull · Back & arms',
            detail: '50 min · Today',
          ),
        ),
        const _ExerciseWeightCard('Barbell Row'),
        const _ExerciseWeightCard('Lat Pulldown'),
        const WorkoutCard(
          WorkoutModel(
            day: 'Fri',
            title: 'Legs · Strength',
            detail: '60 min · Upcoming',
          ),
        ),
        const _ExerciseWeightCard('Squat'),
        const _ExerciseWeightCard('Romanian Deadlift'),
        const UiCard(
          child: Row(
            children: [
              Icon(Icons.bolt, color: Color(0xFFF4877B)),
              SizedBox(width: 9),
              Expanded(
                child: Text(
                  'Your personal training plan. No coach selection needed.',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _ExerciseWeightCard extends StatelessWidget {
  const _ExerciseWeightCard(this.exercise);

  final String exercise;

  @override
  Widget build(BuildContext context) {
    final state = CoachingScope.of(context);
    final weight = state.coachExerciseLoads[exercise] ?? 0;
    return UiCard(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      margin: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          const Icon(Icons.fitness_center, size: 17, color: AppTheme.teal),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              exercise,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
          IconButton(
            tooltip: 'Decrease $exercise weight',
            visualDensity: VisualDensity.compact,
            onPressed: () => state.adjustCoachExerciseLoad(exercise, -2.5),
            icon: const Icon(Icons.remove_circle_outline, size: 18),
          ),
          SizedBox(
            width: 48,
            child: Text(
              '${weight == weight.roundToDouble() ? weight.toInt() : weight} kg',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
          IconButton(
            tooltip: 'Increase $exercise weight',
            visualDensity: VisualDensity.compact,
            onPressed: () => state.adjustCoachExerciseLoad(exercise, 2.5),
            icon: const Icon(Icons.add_circle_outline, size: 18, color: AppTheme.coral),
          ),
        ],
      ),
    );
  }
}
