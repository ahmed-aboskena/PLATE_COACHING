import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../state/coaching_state.dart';
import '../../../widgets/coaching_widgets.dart';

class ChatQuickReply extends StatelessWidget {
  const ChatQuickReply({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => ActionChip(
    label: Text(label, style: const TextStyle(fontSize: 9)),
    onPressed: onPressed,
    backgroundColor: Colors.white,
    side: const BorderSide(color: AppTheme.line),
    visualDensity: VisualDensity.compact,
  );
}

class ChatHeader extends StatelessWidget {
  const ChatHeader({required this.contact, required this.onBack, super.key});

  final CoachingContact contact;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      IconButton(
        tooltip: 'Back to chats',
        visualDensity: VisualDensity.compact,
        onPressed: onBack,
        icon: const Icon(Icons.arrow_back, size: 18),
      ),
      AvatarBadge(contact.initial, small: true),
      const SizedBox(width: 7),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contact.name,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
            Text(
              '${contact.status} · ${contact.type}',
              style: TextStyle(
                color: contact.status == 'Online'
                    ? AppTheme.teal
                    : AppTheme.mute,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
      IconButton(
        tooltip: 'Voice call',
        onPressed: () => Navigator.of(context).pushNamed('/1D'),
        icon: const Icon(Icons.call_outlined, size: 18),
      ),
      IconButton(
        tooltip: 'Video call',
        onPressed: () => Navigator.of(context).pushNamed('/1D'),
        icon: const Icon(Icons.videocam_outlined, size: 18),
      ),
    ],
  );
}
