import 'package:flutter/material.dart';

import '../../../widgets/coaching_widgets.dart';
import '../models/coach_directory_model.dart';

class CoachDirectoryCard extends StatelessWidget {
  const CoachDirectoryCard({
    required this.coach,
    required this.onMessage,
    super.key,
  });

  final CoachDirectoryModel coach;
  final VoidCallback onMessage;

  @override
  Widget build(BuildContext context) => UiCard(
    padding: const EdgeInsets.all(9),
    margin: const EdgeInsets.only(bottom: 7),
    child: Row(
      children: [
        AvatarBadge(coach.initial, small: true),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                coach.name,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '${coach.specialty} · ● ${coach.status}',
                style: TextStyle(
                  color: coach.status == 'Online'
                      ? const Color(0xFF1F9A85)
                      : const Color(0xFF6B7886),
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Message ${coach.name}',
          onPressed: onMessage,
          icon: const Icon(Icons.chat_bubble_outline, size: 17),
        ),
      ],
    ),
  );
}
