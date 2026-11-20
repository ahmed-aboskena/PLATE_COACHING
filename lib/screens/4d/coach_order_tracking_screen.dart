import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../state/coaching_scope.dart';
import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';

class CoachOrderTrackingScreen extends StatelessWidget {
  const CoachOrderTrackingScreen({this.large = false, super.key});

  final bool large;

  @override
  Widget build(BuildContext context) {
    final state = CoachingScope.of(context);
    return AnimatedBuilder(
      animation: state,
      builder: (context, _) {
        final order = state.barOrder;
        return PhoneMockup(
          screenId: 'coach-order',
          title: 'Order tracking',
          large: large,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenHeading(
                order == null
                    ? 'No active order'
                    : 'Order #${state.barOrderNumber}',
                eyebrow: 'Order tracking',
                trailing: order == null
                    ? null
                    : StatusPill(
                        state.barOrderStatus == 'Ready for pickup'
                            ? 'READY'
                            : state.barOrderStatus.toUpperCase(),
                        positive: state.barOrderStatus == 'Ready for pickup',
                      ),
              ),
              if (order == null) ...[
                const UiCard(
                  child: Text('Your reserved bar order will appear here.'),
                ),
                PrimaryButton(
                  label: 'Browse the bar',
                  icon: Icons.local_cafe_outlined,
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/coach-bar'),
                ),
              ] else ...[
                _OrderProgress(status: state.barOrderStatus),
                for (final line in order)
                  UiCard(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Text(
                          line.product.emoji,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                line.product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '${line.product.description} · Qty ${line.quantity}',
                                style: const TextStyle(
                                  color: AppTheme.mute,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'EGP ${line.product.price * line.quantity}',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                UiCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Payment',
                        style: TextStyle(color: AppTheme.mute, fontSize: 10),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Pay at the gym · EGP ${state.barOrderTotal}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.barOrderStatus == 'Ready for pickup')
                  PrimaryButton(
                    label: 'Confirm pickup',
                    icon: Icons.check_circle_outline,
                    onPressed: state.advanceBarOrder,
                  )
                else if (state.barOrderStatus != 'Picked up')
                  PrimaryButton(
                    label: 'Cancel order',
                    outline: true,
                    onPressed: () {
                      state.cancelBarOrder();
                      showAppNotice(context, 'Order cancelled');
                    },
                  )
                else
                  const UiCard(child: Text('Order picked up. Enjoy!')),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _OrderProgress extends StatelessWidget {
  const _OrderProgress({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final steps = const [
      'Placed',
      'Preparing',
      'Ready for pickup',
      'Picked up',
    ];
    final current = steps.indexOf(status).clamp(0, steps.length - 1);
    return UiCard(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
      child: Column(
        children: [
          for (var i = 0; i < steps.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Icon(
                    i < current ? Icons.check_circle : Icons.circle,
                    size: 18,
                    color: i <= current ? AppTheme.teal : AppTheme.line,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      steps[i],
                      style: TextStyle(
                        color: i <= current ? AppTheme.ink : AppTheme.mute,
                        fontWeight: i == current
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                  if (i == current && status == 'Preparing')
                    const Text(
                      'Ready in about 3 min',
                      style: TextStyle(color: AppTheme.mute, fontSize: 9),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
