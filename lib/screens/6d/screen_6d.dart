import 'package:flutter/material.dart';

import '../../state/coaching_scope.dart';
import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';

class Screen6D extends StatelessWidget {
  const Screen6D({this.large = false, super.key});

  final bool large;

  @override
  Widget build(BuildContext context) {
    final state = CoachingScope.of(context);
    const exercises = ['Bench Press', 'Chest Press', 'Incline DB'];
    return PhoneMockup(
      screenId: '6D',
      title: 'Client & plan editor',
      large: large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeading(
            'Ahmed M.',
            trailing: const StatusPill('In gym', positive: true),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 0, bottom: 10),
            child: Text(
              'Member ID · 20418',
              style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
            ),
          ),
          Row(
            children: [
              _stat('12', 'Visits'),
              const SizedBox(width: 6),
              _stat('28', 'Workouts'),
              const SizedBox(width: 6),
              _stat('65', 'Bench PR'),
            ],
          ),
          UiCard(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Next week plan',
                      style: TextStyle(
                        color: Color(0xFF6B7886),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                for (var index = 0; index < exercises.length; index++)
                  Container(
                    constraints: const BoxConstraints(minHeight: 42),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Color(0xFFE3ECEA))),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            exercises[index],
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          tooltip: 'Decrease ${exercises[index]}',
                          onPressed: () => state.adjustLoad(index, -2.5),
                          icon: const Icon(Icons.remove, size: 15),
                        ),
                        SizedBox(
                          width: 48,
                          child: Text(
                            '${state.loads[index].toStringAsFixed(state.loads[index] % 1 == 0 ? 0 : 1)} kg',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          tooltip: 'Increase ${exercises[index]}',
                          onPressed: () => state.adjustLoad(index, 2.5),
                          icon: const Icon(Icons.add, size: 15),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          PrimaryButton(
            label: 'Send updated plan',
            onPressed: () =>
                showAppNotice(context, 'Updated plan sent to Ahmed'),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'Message',
                  icon: Icons.chat_bubble_outline,
                  outline: true,
                  compact: true,
                  onPressed: () => Navigator.of(context).pushNamed('/7D'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: PrimaryButton(
                  label: 'Call',
                  icon: Icons.call_outlined,
                  outline: true,
                  compact: true,
                  onPressed: () => Navigator.of(context).pushNamed('/1D'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) => Expanded(
    child: UiCard(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Text(
            label,
            style: const TextStyle(color: Color(0xFF6B7886), fontSize: 8),
          ),
        ],
      ),
    ),
  );
}
