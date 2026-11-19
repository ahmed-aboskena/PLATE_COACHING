import 'package:flutter/material.dart';

import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';
import 'controllers/plan_editor_controller.dart';
import 'models/plan_exercise_model.dart';
import 'widgets/plan_editor_widgets.dart';
import 'widgets/plan_summary_stat.dart';

class Screen6D extends StatefulWidget {
  const Screen6D({this.large = false, super.key});

  final bool large;

  @override
  State<Screen6D> createState() => _Screen6DState();
}

class _Screen6DState extends State<Screen6D> {
  final _controller = PlanEditorController([65, 50, 22]);
  final _exercises = const [
    PlanExerciseModel(name: 'Bench Press', initialLoad: 65),
    PlanExerciseModel(name: 'Chest Press', initialLoad: 50),
    PlanExerciseModel(name: 'Incline DB', initialLoad: 22),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhoneMockup(
      screenId: '6D',
      title: 'Client & plan editor',
      large: widget.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                const AvatarBadge('A', small: true),
                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ahmed M.',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Member ID · 20418',
                        style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
                      ),
                    ],
                  ),
                ),
                const StatusPill('In gym', positive: true),
              ],
            ),
          ),
          Row(
            children: [
              const PlanSummaryStat(value: '12', label: 'Visits'),
              const SizedBox(width: 6),
              const PlanSummaryStat(value: '28', label: 'Workouts'),
              const SizedBox(width: 6),
              const PlanSummaryStat(value: '65', label: 'Bench PR'),
            ],
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => PlanSummaryCard(
              exercises: _exercises,
              loads: _controller.loads,
              onAdjust: (index, delta) {
                _controller.adjust(index, delta);
              },
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
}
