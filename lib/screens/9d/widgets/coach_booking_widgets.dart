import 'package:flutter/material.dart';

import '../../../widgets/coaching_widgets.dart';

class NextCoachSessionCard extends StatelessWidget {
  const NextCoachSessionCard({required this.onStart, super.key});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) => UiCard(
    borderColor: const Color(0x99F4877B),
    child: Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Next · 7:30 PM',
                style: TextStyle(color: Color(0xFF6B7886), fontSize: 10),
              ),
            ),
            StatusPill('Video', positive: true),
          ],
        ),
        const SizedBox(height: 9),
        const Row(
          children: [
            AvatarBadge('S', small: true),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sara K.',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
                Text(
                  'Legs · 45 min',
                  style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 9),
        PrimaryButton(
          label: 'Start session',
          compact: true,
          onPressed: onStart,
        ),
      ],
    ),
  );
}
