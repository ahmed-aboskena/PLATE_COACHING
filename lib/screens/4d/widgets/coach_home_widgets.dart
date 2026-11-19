import 'package:flutter/material.dart';

import '../../../widgets/coaching_widgets.dart';

class GymOccupancyCard extends StatelessWidget {
  const GymOccupancyCard({super.key});

  @override
  Widget build(BuildContext context) => UiCard(
    child: Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Inside the gym now',
                style: TextStyle(color: Color(0xFF6B7886), fontSize: 10),
              ),
            ),
            StatusPill('● Live', positive: true),
          ],
        ),
        const SizedBox(height: 7),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '42',
              style: TextStyle(
                color: Color(0xFFF4877B),
                fontSize: 44,
                height: 1,
                fontWeight: FontWeight.w700,
              ),
            ),
            Expanded(
              child: Text(
                'people · 42%\nQuiet',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF6B7886),
                  fontSize: 10,
                  height: 1.65,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(9)),
          child: LinearProgressIndicator(
            value: 0.42,
            minHeight: 5,
            backgroundColor: Color(0xFFE3ECEA),
            color: Color(0xFF5FD0BF),
          ),
        ),
      ],
    ),
  );
}
