import 'package:flutter/material.dart';

import '../../../widgets/coaching_widgets.dart';

class BookingSectionLabel extends StatelessWidget {
  const BookingSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 11, bottom: 6),
    child: Text(
      text,
      style: const TextStyle(color: Color(0xFF6B7886), fontSize: 10),
    ),
  );
}

class BookingCoachCard extends StatelessWidget {
  const BookingCoachCard({super.key});

  @override
  Widget build(BuildContext context) => const UiCard(
    child: Row(
      children: [
        AvatarBadge('M', small: true),
        SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Coach Mohamed',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 3),
              Text(
                'Strength & hypertrophy',
                style: TextStyle(color: Color(0xFF6B7886), fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class BookingChoice extends StatelessWidget {
  const BookingChoice({
    required this.text,
    required this.selected,
    this.onTap,
    this.disabled = false,
    super.key,
  });

  final String text;
  final bool selected;
  final VoidCallback? onTap;
  final bool disabled;

  @override
  Widget build(BuildContext context) => InkWell(
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
