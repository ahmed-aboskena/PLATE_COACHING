import 'package:flutter/material.dart';

import '../../state/coaching_scope.dart';
import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';

class Screen8A extends StatefulWidget {
  const Screen8A({this.large = false, super.key});

  final bool large;

  @override
  State<Screen8A> createState() => _Screen8AState();
}

class _Screen8AState extends State<Screen8A> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _send() {
    final text = _messageController.text.trim();
    if (text.isEmpty) {
      showAppNotice(context, 'Write a message before sending.');
      return;
    }
    CoachingScope.of(context).addMemberMessage(text);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final state = CoachingScope.of(context);
    return PhoneMockup(
      screenId: '8A',
      title: 'My coach',
      large: widget.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeading(
            'My coach',
            trailing: IconButton(
              tooltip: 'Call Mohamed',
              onPressed: () => Navigator.of(context).pushNamed('/1D'),
              icon: const Icon(Icons.call_outlined, size: 19),
            ),
          ),
          UiCard(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const AvatarBadge('M'),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mohamed Ali',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Strength & hypertrophy · Online',
                        style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1F9A85),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          UiCard(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Today’s plan',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        'Updated today',
                        style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
                      ),
                    ],
                  ),
                ),
                for (final exercise in const [
                  ('Bench Press', '62.5 → 65 kg'),
                  ('Chest Press', '45 → 50 kg'),
                  ('Incline DB', '24 → 22 kg'),
                ])
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Color(0xFFE3ECEA))),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            exercise.$1,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                        Text(
                          exercise.$2,
                          style: const TextStyle(
                            color: Color(0xFF1F9A85),
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          for (final message in state.memberMessages)
            Align(
              alignment: message.fromCoach
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 216),
                margin: const EdgeInsets.only(bottom: 7),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: message.fromCoach
                      ? Colors.white
                      : const Color(0xFFF4877B),
                  border: message.fromCoach
                      ? Border.all(color: const Color(0xFFE3ECEA))
                      : null,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(14),
                    topRight: const Radius.circular(14),
                    bottomLeft: Radius.circular(message.fromCoach ? 4 : 14),
                    bottomRight: Radius.circular(message.fromCoach ? 14 : 4),
                  ),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: message.fromCoach ? null : Colors.white,
                    fontSize: 10,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  onSubmitted: (_) => _send(),
                  decoration: const InputDecoration(
                    hintText: 'Type a message…',
                    hintStyle: TextStyle(
                      color: Color(0xFF6B7886),
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              IconButton.filled(
                onPressed: _send,
                tooltip: 'Send message',
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFFF4877B),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.arrow_upward, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
