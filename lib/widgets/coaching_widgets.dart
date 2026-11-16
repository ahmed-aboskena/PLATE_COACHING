import 'package:flutter/material.dart';

import '../app/app_theme.dart';

class UiCard extends StatelessWidget {
  const UiCard({
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.margin = const EdgeInsets.only(bottom: 10),
    this.borderColor,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderColor ?? AppTheme.line),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0B285A5A),
          blurRadius: 14,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: child,
  );
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.outline = false,
    this.compact = false,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool outline;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final buttonChild = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[Icon(icon, size: 15), const SizedBox(width: 6)],
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );

    return SizedBox(
      width: double.infinity,
      child: outline
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF4B5563),
                side: const BorderSide(color: Color(0xFF4B5563)),
                padding: EdgeInsets.symmetric(vertical: compact ? 10 : 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: buttonChild,
            )
          : FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.coral,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: compact ? 10 : 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: buttonChild,
            ),
    );
  }
}

class AvatarBadge extends StatelessWidget {
  const AvatarBadge(this.label, {this.small = false, super.key});

  final String label;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final size = small ? 36.0 : 44.0;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0x29F4877B),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppTheme.coral,
          fontWeight: FontWeight.w800,
          fontSize: small ? 12 : 15,
        ),
      ),
    );
  }
}

class StatusPill extends StatelessWidget {
  const StatusPill(this.label, {this.positive = false, super.key});

  final String label;
  final bool positive;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(
      color: positive ? const Color(0xFFD6F3EC) : AppTheme.coral,
      borderRadius: BorderRadius.circular(99),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: positive ? AppTheme.teal : Colors.white,
        fontSize: 9,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class ScreenHeading extends StatelessWidget {
  const ScreenHeading(this.title, {this.eyebrow, this.trailing, super.key});

  final String title;
  final String? eyebrow;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (eyebrow != null)
                Text(
                  eyebrow!,
                  style: const TextStyle(color: AppTheme.mute, fontSize: 10),
                ),
              Text(
                title,
                style: const TextStyle(
                  color: AppTheme.ink,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        ?trailing,
      ],
    ),
  );
}

class ScreenNavButton extends StatelessWidget {
  const ScreenNavButton({
    required this.icon,
    required this.label,
    required this.route,
    required this.selected,
    super.key,
  });

  final IconData icon;
  final String label;
  final String route;
  final bool selected;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => Navigator.of(context).pushReplacementNamed(route),
    borderRadius: BorderRadius.circular(10),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 17,
            color: selected ? AppTheme.coral : AppTheme.mute,
          ),
          Text(
            label,
            style: TextStyle(
              color: selected ? AppTheme.coral : AppTheme.mute,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

void showAppNotice(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.maybeOf(context);
  messenger
    ?..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
}
