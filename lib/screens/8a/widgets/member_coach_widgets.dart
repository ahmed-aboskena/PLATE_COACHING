import 'package:flutter/material.dart';

import '../../../widgets/coaching_widgets.dart';

class MemberCoachHeaderCard extends StatelessWidget {
  const MemberCoachHeaderCard({super.key});

  @override
  Widget build(BuildContext context) => UiCard(
    padding: const EdgeInsets.all(10),
    child: const Row(
      children: [
        AvatarBadge('M'),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mohamed Ali',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 3),
              Text(
                'Strength & hypertrophy · Online',
                style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 8,
          height: 8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0xFF1F9A85),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    ),
  );
}
