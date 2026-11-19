import 'package:flutter/material.dart';

import '../../../widgets/coaching_widgets.dart';

class ProfileMenuCard extends StatelessWidget {
  const ProfileMenuCard({
    required this.onMyWorkout,
    required this.onOtherCoaches,
    required this.onLogOut,
    super.key,
  });

  final VoidCallback onMyWorkout;
  final VoidCallback onOtherCoaches;
  final VoidCallback onLogOut;

  @override
  Widget build(BuildContext context) => UiCard(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    child: Column(
      children: [
        _menuRow('My workout', onMyWorkout),
        _menuRow('Other coaches', onOtherCoaches),
        _menuRow('Log out', onLogOut),
      ],
    ),
  );

  Widget _menuRow(String label, VoidCallback onTap) => InkWell(
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
          const Icon(Icons.chevron_right, size: 16, color: Color(0xFF6B7886)),
        ],
      ),
    ),
  );
}
