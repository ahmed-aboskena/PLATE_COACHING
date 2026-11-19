import 'package:flutter/material.dart';

import '../../../widgets/coaching_widgets.dart';
import '../models/workout_model.dart';

class NextLiveSessionCard extends StatelessWidget {
  const NextLiveSessionCard({required this.onJoin, super.key});

  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) => UiCard(
    borderColor: const Color(0x99F4877B),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Next live session',
                style: TextStyle(color: Color(0xFF6B7886), fontSize: 10),
              ),
            ),
            StatusPill('in 2h 15m', positive: true),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            AvatarBadge('M', small: true),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upper body · Video',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Today · 7:30 PM · 45 min',
                    style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        PrimaryButton(
          label: 'Join session',
          icon: Icons.videocam,
          onPressed: onJoin,
        ),
      ],
    ),
  );
}

class OnlinePlanCard extends StatelessWidget {
  const OnlinePlanCard({super.key});

  @override
  Widget build(BuildContext context) => const UiCard(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Online plan',
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
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Ends in',
              style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
            ),
            Text('18 days', style: TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ],
    ),
  );
}

class WorkoutCard extends StatelessWidget {
  const WorkoutCard(this.workout, {super.key});

  final WorkoutModel workout;

  @override
  Widget build(BuildContext context) => UiCard(
    padding: const EdgeInsets.all(9),
    margin: const EdgeInsets.only(bottom: 7),
    child: Row(
      children: [
        AvatarBadge(workout.day, small: true),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                workout.title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                workout.detail,
                style: const TextStyle(color: Color(0xFF6B7886), fontSize: 9),
              ),
            ],
          ),
        ),
        if (workout.done) const StatusPill('✓ Done', positive: true),
      ],
    ),
  );
}
