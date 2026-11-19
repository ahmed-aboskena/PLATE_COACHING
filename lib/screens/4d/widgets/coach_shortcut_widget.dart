import 'package:flutter/material.dart';

class CoachShortcutCard extends StatelessWidget {
  const CoachShortcutCard({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(13),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE3ECEA)),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 9)),
        ],
      ),
    ),
  );
}
