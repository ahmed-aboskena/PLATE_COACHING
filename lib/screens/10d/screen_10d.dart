import 'package:flutter/material.dart';

import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';

class Screen10D extends StatelessWidget {
  const Screen10D({this.large = false, super.key});

  final bool large;

  @override
  Widget build(BuildContext context) => PhoneMockup(
    screenId: '10D',
    title: 'Profile & contract',
    large: large,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenHeading(
          'Profile',
          trailing: IconButton(
            tooltip: 'Settings',
            onPressed: () => showAppNotice(context, 'Profile settings opened'),
            icon: const Icon(Icons.settings_outlined, size: 18),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              AvatarBadge('M'),
              SizedBox(width: 9),
              Expanded(
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
                      'Strength & hypertrophy',
                      style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
                    ),
                  ],
                ),
              ),
              StatusPill('COACH'),
            ],
          ),
        ),
        UiCard(
          borderColor: const Color(0x99F4877B),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contract',
                    style: TextStyle(color: Color(0xFF6B7886), fontSize: 10),
                  ),
                  StatusPill('Active', positive: true),
                ],
              ),
              const SizedBox(height: 5),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '214',
                        style: TextStyle(
                          color: Color(0xFFF4877B),
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'days left',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(9)),
                child: LinearProgressIndicator(
                  value: 0.59,
                  minHeight: 5,
                  backgroundColor: Color(0xFFE3ECEA),
                  color: Color(0xFF5FD0BF),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 7),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Ends May 17, 2027',
                        style: TextStyle(color: Color(0xFF6B7886), fontSize: 8),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Managed by admin',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Color(0xFF6B7886), fontSize: 8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            _stat('12', 'Clients'),
            const SizedBox(width: 6),
            _stat('5', 'Online'),
            const SizedBox(width: 6),
            _stat('24', 'Visits'),
          ],
        ),
        UiCard(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          child: Column(
            children: [
              _menuRow(
                context,
                'My workout',
                () => showAppNotice(context, 'Opening your personal workout'),
              ),
              _menuRow(
                context,
                'Other coaches',
                () => Navigator.of(context).pushNamed('/8D'),
              ),
              _menuRow(
                context,
                'Log out',
                () => showAppNotice(
                  context,
                  'You are signed in as Coach Mohamed',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

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

  Widget _menuRow(BuildContext context, String label, VoidCallback onTap) =>
      InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFFE3ECEA))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 11)),
              const Icon(
                Icons.chevron_right,
                size: 16,
                color: Color(0xFF6B7886),
              ),
            ],
          ),
        ),
      );
}
