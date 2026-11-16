import 'package:flutter/material.dart';

import '../../state/coaching_scope.dart';
import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';

class Screen9D extends StatelessWidget {
  const Screen9D({this.large = false, super.key});

  final bool large;

  @override
  Widget build(BuildContext context) {
    final state = CoachingScope.of(context);
    return PhoneMockup(
      screenId: '9D',
      title: 'Online training',
      large: large,
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
                        state.acceptingBookings
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
                  value: state.acceptingBookings,
                  onChanged: (_) => state.toggleBookings(),
                  activeTrackColor: const Color(0xFF5FD0BF),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
          ),
          if (!state.acceptingBookings)
            const Padding(
              padding: EdgeInsets.only(left: 2, bottom: 8),
              child: Text(
                'New booking requests are paused.',
                style: TextStyle(color: Color(0xFFBF7414), fontSize: 9),
              ),
            ),
          UiCard(
            borderColor: const Color(0x99F4877B),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Next · 7:30 PM',
                        style: TextStyle(
                          color: Color(0xFF6B7886),
                          fontSize: 10,
                        ),
                      ),
                    ),
                    StatusPill('Video', positive: true),
                  ],
                ),
                const SizedBox(height: 9),
                const Row(
                  children: [
                    AvatarBadge('S', small: true),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sara K.',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Legs · 45 min',
                          style: TextStyle(
                            color: Color(0xFF6B7886),
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                PrimaryButton(
                  label: 'Start session',
                  compact: true,
                  onPressed: () => Navigator.of(context).pushNamed('/1D'),
                ),
              ],
            ),
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
          if (state.requestDecision == null)
            UiCard(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'New request',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Nour A. · Fri 4:00 PM · Video',
                    style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
                  ),
                  const SizedBox(height: 9),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          label: 'Decline',
                          outline: true,
                          compact: true,
                          onPressed: () {
                            state.decideRequest('Declined');
                            showAppNotice(context, 'Booking request declined');
                          },
                        ),
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: PrimaryButton(
                          label: 'Accept',
                          compact: true,
                          onPressed: () {
                            state.decideRequest('Accepted');
                            showAppNotice(
                              context,
                              'Nour’s session request accepted',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else
            UiCard(
              child: Row(
                children: [
                  Text(
                    state.requestDecision!,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Nour A. · Fri 4:00 PM · Video',
                    style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
