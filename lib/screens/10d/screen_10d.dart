import 'package:flutter/material.dart';

import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';
import 'widgets/profile_stat_card.dart';
import 'widgets/coach_profile_widgets.dart';
import 'widgets/profile_menu_card.dart';

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
        const ContractCard(),
        Row(
          children: [
            const ProfileStatCard(value: '12', label: 'Clients'),
            const SizedBox(width: 6),
            const ProfileStatCard(value: '5', label: 'Online'),
            const SizedBox(width: 6),
            const ProfileStatCard(value: '24', label: 'Visits'),
          ],
        ),
        ProfileMenuCard(
          onMyWorkout: () =>
              showAppNotice(context, 'Opening your personal workout'),
          onOtherCoaches: () => Navigator.of(context).pushNamed('/8D'),
          onLogOut: () =>
              showAppNotice(context, 'You are signed in as Coach Mohamed'),
        ),
      ],
    ),
  );
}
