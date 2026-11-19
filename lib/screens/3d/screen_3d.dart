import 'package:flutter/material.dart';

import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';
import 'controllers/booking_controller.dart';
import 'widgets/booking_widgets.dart';

class Screen3D extends StatefulWidget {
  const Screen3D({this.large = false, super.key});

  final bool large;

  @override
  State<Screen3D> createState() => _Screen3DState();
}

class _Screen3DState extends State<Screen3D> {
  final _controller = BookingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      large: widget.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeading(
            'Book a session',
            trailing: IconButton(
              tooltip: 'Close',
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.close, size: 18),
            ),
          ),
          const BookingCoachCard(),
          const BookingSectionLabel('Session type'),
          Row(
            children: [
              for (final type in ['Video', 'Voice'])
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: BookingChoice(
                      text: type,
                      selected: type == _controller.type,
                      onTap: () => setState(() => _controller.setType(type)),
                    ),
                  ),
                ),
            ],
          ),
          const BookingSectionLabel('Pick a day'),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              for (final day in days)
                BookingChoice(
                  text: day,
                  selected: day == _controller.day,
                  onTap: () => setState(() => _controller.setDay(day)),
                ),
            ],
          ),
          const BookingSectionLabel('Available times'),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 2.25,
            children: [
              for (final time in times)
                BookingChoice(
                  text: time,
                  selected: time == _controller.time,
                  onTap: time == '9:00 PM'
                      ? null
                      : () => setState(() => _controller.setTime(time)),
                  disabled: time == '9:00 PM',
                ),
            ],
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            label: 'Confirm · ${_controller.day}, ${_controller.time}',
            onPressed: () => showAppNotice(
              context,
              'Booked ${_controller.type.toLowerCase()} session · ${_controller.day}, ${_controller.time}',
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
}
