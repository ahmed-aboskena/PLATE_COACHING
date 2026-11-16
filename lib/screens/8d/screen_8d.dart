import 'package:flutter/material.dart';

import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';

class Screen8D extends StatefulWidget {
  const Screen8D({this.large = false, super.key});

  final bool large;

  @override
  State<Screen8D> createState() => _Screen8DState();
}

class _Screen8DState extends State<Screen8D> {
  final _queryController = TextEditingController();

  static const _coaches = [
    ('K', 'Coach Khaled', 'Strength', 'Online'),
    ('R', 'Coach Rana', 'Mobility', 'Online'),
    ('H', 'Coach Hady', 'CrossFit', 'Busy'),
    ('M', 'Coach Maya', 'Yoga', 'Offline'),
  ];

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _queryController.text.toLowerCase();
    final visible = _coaches
        .where(
          (coach) => '${coach.$2} ${coach.$3}'.toLowerCase().contains(query),
        )
        .toList();
    return PhoneMockup(
      screenId: '8D',
      title: 'Coaches',
      large: widget.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenHeading('Coaches', trailing: StatusPill('COACH')),
          TextField(
            controller: _queryController,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, size: 18),
              hintText: 'Search coaches',
              hintStyle: TextStyle(fontSize: 11),
            ),
          ),
          const SizedBox(height: 10),
          for (final coach in visible)
            UiCard(
              padding: const EdgeInsets.all(9),
              margin: const EdgeInsets.only(bottom: 7),
              child: Row(
                children: [
                  AvatarBadge(coach.$1, small: true),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coach.$2,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${coach.$3} · ● ${coach.$4}',
                          style: TextStyle(
                            color: coach.$4 == 'Online'
                                ? const Color(0xFF1F9A85)
                                : const Color(0xFF6B7886),
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Message ${coach.$2}',
                    onPressed: () {
                      if (coach.$4 != 'Online') {
                        showAppNotice(
                          context,
                          '${coach.$2} is ${coach.$4.toLowerCase()} right now',
                        );
                      } else {
                        Navigator.of(context).pushNamed('/7D');
                      }
                    },
                    icon: const Icon(Icons.chat_bubble_outline, size: 17),
                  ),
                ],
              ),
            ),
          if (visible.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'No coaches found.',
                  style: TextStyle(color: Color(0xFF6B7886), fontSize: 11),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
