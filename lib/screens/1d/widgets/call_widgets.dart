import 'package:flutter/material.dart';

class CallSegmentedControl extends StatelessWidget {
  const CallSegmentedControl({
    required this.mode,
    required this.onChanged,
    super.key,
  });

  final String mode;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(3),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE3ECEA)),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        for (final type in const ['Voice', 'Video'])
          Expanded(
            child: TextButton(
              onPressed: () => onChanged(type),
              style: TextButton.styleFrom(
                backgroundColor: mode == type
                    ? const Color(0xFF5FD0BF)
                    : Colors.transparent,
                foregroundColor: mode == type
                    ? Colors.white
                    : const Color(0xFF6B7886),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              child: Text(type),
            ),
          ),
      ],
    ),
  );
}

class CallControlButton extends StatelessWidget {
  const CallControlButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.active = false,
    this.danger = false,
    super.key,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool active;
  final bool danger;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: tooltip,
    child: Material(
      color: danger
          ? const Color(0xFFD9483B)
          : active
          ? const Color(0x29F4877B)
          : Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 43,
          height: 43,
          child: Icon(
            icon,
            color: danger ? Colors.white : const Color(0xFF1D2733),
            size: 18,
          ),
        ),
      ),
    ),
  );
}
