import 'package:flutter/material.dart';

import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';

class Screen2D extends StatelessWidget {
  const Screen2D({this.large = false, super.key});

  final bool large;

  @override
  Widget build(BuildContext context) => PhoneMockup(
    screenId: '2D',
    title: 'Online training',
    large: large,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenHeading(
          'Online training',
          eyebrow: 'with Coach Mohamed',
          trailing: const StatusPill('ONLINE'),
        ),
        UiCard(
          borderColor: const Color(0x99F4877B),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Next live session',
                      style: TextStyle(color: Color(0xFF6B7886), fontSize: 10),
                    ),
                  ),
                  StatusPill('in 2h 15m', positive: true),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  AvatarBadge('M', small: true),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upper body · Video',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Today · 7:30 PM · 45 min',
                          style: TextStyle(
                            color: Color(0xFF6B7886),
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              PrimaryButton(
                label: 'Join session',
                icon: Icons.videocam,
                onPressed: () => Navigator.of(context).pushNamed('/1D'),
              ),
            ],
          ),
        ),
        UiCard(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Online plan',
                      style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
                    ),
                    Text(
                      'Active',
                      style: TextStyle(
                        color: Color(0xFF1F9A85),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Ends in',
                    style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
                  ),
                  Text(
                    '18 days',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 8, top: 4),
          child: Text(
            'This week',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ),
        _workout('Mon', 'Legs · Video', '40 min', done: true),
        _workout('Fri', 'Back · Voice', '6:00 PM'),
        Row(
          children: [
            Expanded(
              child: PrimaryButton(
                label: 'Message',
                icon: Icons.chat_bubble_outline,
                outline: true,
                compact: true,
                onPressed: () => Navigator.of(context).pushNamed('/8A'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: PrimaryButton(
                label: 'Book',
                icon: Icons.add,
                outline: true,
                compact: true,
                onPressed: () => Navigator.of(context).pushNamed('/3D'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        InkWell(
          onTap: () => showAppNotice(
            context,
            'Your consistency is up 8% this month — keep going!',
          ),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFD6F3EC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '💡 Your consistency is up 8% this month',
              style: TextStyle(color: Color(0xFF32756A), fontSize: 10),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _workout(
    String day,
    String name,
    String detail, {
    bool done = false,
  }) => UiCard(
    padding: const EdgeInsets.all(9),
    margin: const EdgeInsets.only(bottom: 7),
    child: Row(
      children: [
        AvatarBadge(day, small: true),
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
        if (done) const StatusPill('✓ Done', positive: true),
      ],
    ),
  );
}
