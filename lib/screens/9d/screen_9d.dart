import 'package:flutter/material.dart';

import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';
import 'controllers/coach_booking_controller.dart';
import 'widgets/booking_request_card.dart';
import 'widgets/coach_booking_widgets.dart';

class Screen9D extends StatefulWidget {
  const Screen9D({this.large = false, super.key});

  final bool large;

  @override
  State<Screen9D> createState() => _Screen9DState();
}

class _Screen9DState extends State<Screen9D> {
  final _controller = CoachBookingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhoneMockup(
      screenId: '9D',
      title: 'Online training',
      large: widget.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenHeading('Online training', trailing: StatusPill('COACH')),
          UiCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Accepting bookings',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _controller.acceptingBookings
                            ? '5 online clients · 3 sessions today'
                            : 'Bookings are paused',
                        style: const TextStyle(
                          color: Color(0xFF6B7886),
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: _controller.acceptingBookings,
                  onChanged: (_) =>
                      setState(() => _controller.toggleBookings()),
                  activeTrackColor: const Color(0xFF5FD0BF),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
          ),
          if (!_controller.acceptingBookings)
            const Padding(
              padding: EdgeInsets.only(left: 2, bottom: 8),
              child: Text(
                'New booking requests are paused.',
                style: TextStyle(color: Color(0xFFBF7414), fontSize: 9),
              ),
            ),
          NextCoachSessionCard(
            onStart: () => Navigator.of(context).pushNamed('/1D'),
          ),
          UiCard(
            padding: const EdgeInsets.all(9),
            child: const Row(
              children: [
                AvatarBadge('O', small: true),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Omar H.',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '8:30 PM · Back · Voice',
                        style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
                      ),
                    ],
                  ),
                ),
                StatusPill('Upcoming', positive: true),
              ],
            ),
          ),
          BookingRequestCard(
            decision: _controller.requestDecision,
            onDecline: () {
              setState(() => _controller.decideRequest('Declined'));
              showAppNotice(context, 'Booking request declined');
            },
            onAccept: () {
              setState(() => _controller.decideRequest('Accepted'));
              showAppNotice(context, 'Nour’s session request accepted');
            },
          ),
        ],
      ),
    );
  }
}
