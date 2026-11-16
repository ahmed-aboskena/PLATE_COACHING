import 'package:flutter/material.dart';

import '../../state/coaching_scope.dart';
import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';

class Screen3D extends StatelessWidget {
  const Screen3D({this.large = false, super.key});

  final bool large;

  @override
  Widget build(BuildContext context) {
    final state = CoachingScope.of(context);
    const days = ['Today', 'Fri 16', 'Sat 17', 'Sun 18'];
    const times = [
      '5:00 PM',
      '6:00 PM',
      '7:30 PM',
      '8:30 PM',
      '9:00 PM',
      '9:30 PM',
    ];
    return PhoneMockup(
      screenId: '3D',
      title: 'Book a session',
      large: large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenHeading('Book a session'),
          UiCard(
            child: const Row(
              children: [
                AvatarBadge('M', small: true),
                SizedBox(width: 9),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Coach Mohamed',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Strength & hypertrophy',
                        style: TextStyle(
                          color: Color(0xFF6B7886),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _label('Session type'),
          Row(
            children: [
              for (final type in ['Video', 'Voice'])
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: _choice(
                      type,
                      type == state.bookingType,
                      () => state.setBookingType(type),
                    ),
                  ),
                ),
            ],
          ),
          _label('Pick a day'),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              for (final day in days)
                _choice(
                  day,
                  day == state.bookingDay,
                  () => state.setBookingDay(day),
                ),
            ],
          ),
          _label('Available times'),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 2.25,
            children: [
              for (final time in times)
                _choice(
                  time,
                  time == state.bookingTime,
                  time == '9:00 PM' ? null : () => state.setBookingTime(time),
                  disabled: time == '9:00 PM',
                ),
            ],
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            label: 'Confirm · ${state.bookingDay}, ${state.bookingTime}',
            onPressed: () => showAppNotice(
              context,
              'Booked ${state.bookingType.toLowerCase()} session · ${state.bookingDay}, ${state.bookingTime}',
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Included in your online plan',
              style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(top: 11, bottom: 6),
    child: Text(
      text,
      style: const TextStyle(color: Color(0xFF6B7886), fontSize: 10),
    ),
  );

  Widget _choice(
    String text,
    bool selected,
    VoidCallback? onTap, {
    bool disabled = false,
  }) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(11),
    child: Container(
      constraints: const BoxConstraints(minHeight: 34),
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF5FD0BF) : Colors.white,
        border: Border.all(
          color: selected ? const Color(0xFF5FD0BF) : const Color(0xFFE3ECEA),
        ),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: disabled
              ? const Color(0xFFB7C0C2)
              : selected
              ? Colors.white
              : const Color(0xFF1D2733),
          fontSize: 9,
          fontWeight: FontWeight.w600,
          decoration: disabled ? TextDecoration.lineThrough : null,
        ),
      ),
    ),
  );
}
