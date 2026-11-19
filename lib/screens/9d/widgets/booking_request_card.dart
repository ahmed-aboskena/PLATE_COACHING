import 'package:flutter/material.dart';

import '../../../widgets/coaching_widgets.dart';

class BookingRequestCard extends StatelessWidget {
  const BookingRequestCard({
    required this.decision,
    required this.onDecline,
    required this.onAccept,
    super.key,
  });

  final String? decision;
  final VoidCallback onDecline;
  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    if (decision == null) {
      return UiCard(
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
                    onPressed: onDecline,
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: PrimaryButton(
                    label: 'Accept',
                    compact: true,
                    onPressed: onAccept,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return UiCard(
      child: Row(
        children: [
          Text(
            decision!,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          const Text(
            'Nour A. · Fri 4:00 PM · Video',
            style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
          ),
        ],
      ),
    );
  }
}
