import 'package:flutter/material.dart';

import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';
import 'models/workout_model.dart';
import 'widgets/member_training_widgets.dart';

class Screen2D extends StatelessWidget {
  const Screen2D({this.large = false, super.key});

  final bool large;

  @override
  Widget build(BuildContext context) => PhoneMockup(
    screenId: '2D',
    title: 'Online training',
    large: large,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenHeading(
          'Online training',
          eyebrow: 'with Coach Mohamed',
          trailing: const StatusPill('ONLINE'),
        ),
        NextLiveSessionCard(
          onJoin: () => Navigator.of(context).pushNamed('/1D'),
        ),
        const OnlinePlanCard(),
        const WorkoutCard(
          WorkoutModel(
            day: 'Mon',
            title: 'Legs · Video',
            detail: '40 min',
            done: true,
          ),
        ),
        const WorkoutCard(
          WorkoutModel(day: 'Fri', title: 'Back · Voice', detail: '6:00 PM'),
        ),
        Row(
          children: [
            Expanded(
              child: PrimaryButton(
                label: 'Message',
                icon: Icons.chat_bubble_outline,
                outline: true,
                compact: true,
                onPressed: () => Navigator.of(context).pushNamed('/8A'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: PrimaryButton(
                label: 'Book',
                icon: Icons.add,
                outline: true,
                compact: true,
                onPressed: () => Navigator.of(context).pushNamed('/3D'),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
