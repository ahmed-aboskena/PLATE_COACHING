import 'package:flutter/material.dart';

import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';

class Screen4D extends StatelessWidget {
  const Screen4D({this.large = false, super.key});

  final bool large;

  @override
  Widget build(BuildContext context) => PhoneMockup(
    screenId: '4D',
    title: 'Coach home',
    large: large,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ScreenHeading(
          'Coach Mohamed',
          eyebrow: 'Good evening',
          trailing: StatusPill('COACH'),
        ),
        UiCard(
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
              ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: const LinearProgressIndicator(
                  value: 0.42,
                  minHeight: 5,
                  backgroundColor: Color(0xFFE3ECEA),
                  color: Color(0xFF5FD0BF),
                ),
              ),
            ],
          ),
        ),
        GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          childAspectRatio: 0.88,
          children: [
            _shortcut(context, Icons.fitness_center, 'Train', '/2D'),
            _shortcut(context, Icons.videocam, 'Online', '/9D'),
            _shortcut(context, Icons.people_outline, 'Clients', '/5D'),
            _shortcut(context, Icons.chat_bubble_outline, 'Messages', '/7D'),
          ],
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today’s sessions',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
              Text(
                '2',
                style: TextStyle(color: Color(0xFF6B7886), fontSize: 10),
              ),
            ],
          ),
        ),
        _session(context, 'A', 'Ahmed M.', 'Chest day · In gym', '6:00 PM'),
        _session(context, 'S', 'Sara K.', 'Legs · Online plan', '7:30 PM'),
      ],
    ),
  );

  Widget _shortcut(
    BuildContext context,
    IconData icon,
    String label,
    String route,
  ) => InkWell(
    onTap: () => Navigator.of(context).pushNamed(route),
    borderRadius: BorderRadius.circular(13),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE3ECEA)),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 9)),
        ],
      ),
    ),
  );

  Widget _session(
    BuildContext context,
    String initial,
    String name,
    String detail,
    String time,
  ) => InkWell(
    onTap: () => Navigator.of(context).pushNamed('/6D'),
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
