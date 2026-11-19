import 'package:flutter/material.dart';

import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';
import 'widgets/coach_home_widgets.dart';
import 'widgets/coach_session_card.dart';
import 'widgets/coach_shortcut_widget.dart';

class Screen4D extends StatelessWidget {
  const Screen4D({this.large = false, super.key});

  final bool large;

  @override
  Widget build(BuildContext context) => PhoneMockup(
    screenId: '4D',
    title: 'Coach home',
    large: large,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ScreenHeading(
          'Coach Mohamed',
          eyebrow: 'Good evening',
          trailing: StatusPill('COACH'),
        ),
        const GymOccupancyCard(),
        GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          childAspectRatio: 0.88,
          children: [
            CoachShortcutCard(
              icon: Icons.fitness_center,
              label: 'Train',
              onTap: () => Navigator.of(context).pushNamed('/2D'),
            ),
            CoachShortcutCard(
              icon: Icons.local_cafe_outlined,
              label: 'Bar',
              onTap: () => showAppNotice(context, 'Bar area is not available'),
            ),
            CoachShortcutCard(
              icon: Icons.videocam,
              label: 'Online',
              onTap: () => Navigator.of(context).pushNamed('/9D'),
            ),
            CoachShortcutCard(
              icon: Icons.people_outline,
              label: 'Coaches',
              onTap: () => Navigator.of(context).pushNamed('/8D'),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today’s sessions',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
              Text(
                '2',
                style: TextStyle(color: Color(0xFF6B7886), fontSize: 10),
              ),
            ],
          ),
        ),
        CoachSessionCard(
          initial: 'A',
          name: 'Ahmed M.',
          detail: 'Chest day · In gym',
          time: '6:00 PM',
          onTap: () => Navigator.of(context).pushNamed('/6D'),
        ),
        CoachSessionCard(
          initial: 'S',
          name: 'Sara K.',
          detail: 'Legs · Online plan',
          time: '7:30 PM',
          onTap: () => Navigator.of(context).pushNamed('/6D'),
        ),
      ],
    ),
  );
}
