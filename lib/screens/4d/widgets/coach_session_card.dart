import 'package:flutter/material.dart';

import '../../../widgets/coaching_widgets.dart';

class CoachSessionCard extends StatelessWidget {
  const CoachSessionCard({
    required this.initial,
    required this.name,
    required this.detail,
    required this.time,
    required this.onTap,
    super.key,
  });

  final String initial;
  final String name;
  final String detail;
  final String time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: UiCard(
      padding: const EdgeInsets.all(9),
      child: Row(
        children: [
          AvatarBadge(initial, small: true),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  detail,
                  style: const TextStyle(color: Color(0xFF6B7886), fontSize: 9),
                ),
              ],
            ),
          ),
          StatusPill(time, positive: true),
        ],
      ),
    ),
  );
}
