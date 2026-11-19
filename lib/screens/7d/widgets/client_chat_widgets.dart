import 'package:flutter/material.dart';

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
    side: const BorderSide(color: Color(0xFFE3ECEA)),
    visualDensity: VisualDensity.compact,
  );
}

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      const AvatarBadge('A', small: true),
      const SizedBox(width: 7),
      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ahmed M.',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
            Text(
              '● Online plan',
              style: TextStyle(color: Color(0xFF1F9A85), fontSize: 9),
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
