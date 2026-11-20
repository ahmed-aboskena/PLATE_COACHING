import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../state/coaching_scope.dart';
import '../../state/coaching_state.dart';
import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';

class CoachBarScreen extends StatefulWidget {
  const CoachBarScreen({this.large = false, super.key});

  final bool large;

  @override
  State<CoachBarScreen> createState() => _CoachBarScreenState();
}

class _CoachBarScreenState extends State<CoachBarScreen> {
  String _category = 'Shakes';

  @override
  Widget build(BuildContext context) {
    final state = CoachingScope.of(context);
    final products = state.barProducts
        .where((product) => product.category == _category)
        .toList();
    return PhoneMockup(
      screenId: 'coach-bar',
      title: 'Gym bar',
      large: widget.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeading(
            'Gym bar',
            eyebrow: 'Coach · order for yourself',
            trailing: IconButton(
              tooltip: 'Track order',
              onPressed: state.barOrder == null
                  ? null
                  : () => Navigator.of(context).pushNamed('/coach-order'),
              icon: const Icon(Icons.receipt_long_outlined),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final category in const [
                  'Shakes',
                  'Meals',
                  'Supplements',
                ]) ...[
                  ChoiceChip(
                    label: Text(category),
                    selected: _category == category,
                    onSelected: (_) => setState(() => _category = category),
                  ),
                  const SizedBox(width: 6),
                ],
              ],
            ),
          ),
          const SizedBox(height: 10),
          for (final product in products)
            _ProductCard(
              product: product,
              quantity: state.barCart
                  .where((line) => line.product.name == product.name)
                  .fold(0, (sum, line) => sum + line.quantity),
              onAdd: () => state.addBarProduct(product),
              onRemove: () => state.changeBarQuantity(product, -1),
            ),
          if (state.barOrder != null)
            UiCard(
              padding: const EdgeInsets.all(11),
              child: Row(
                children: [
                  const Icon(Icons.local_cafe_outlined, color: AppTheme.teal),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Order #${state.barOrderNumber} · ${state.barOrderStatus}',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/coach-order'),
                    child: const Text('Track'),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 4),
          PrimaryButton(
            label: state.barCartCount == 0
                ? 'Your basket is empty'
                : '${state.barCartCount} ${state.barCartCount == 1 ? 'item' : 'items'}  ·  Reserve · EGP ${state.barCartTotal}',
            icon: Icons.shopping_bag_outlined,
            onPressed: () {
              if (!state.reserveBarOrder()) {
                showAppNotice(context, 'Add a product to your basket first');
                return;
              }
              Navigator.of(context).pushNamed('/coach-order');
            },
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  final BarProduct product;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => UiCard(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
    margin: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppTheme.paleTeal,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(product.emoji, style: const TextStyle(fontSize: 22)),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(
                product.available
                    ? product.description
                    : 'Out today · ${product.description}',
                style: const TextStyle(color: AppTheme.mute, fontSize: 10),
              ),
              Text(
                'EGP ${product.price}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        if (product.available)
          quantity == 0
              ? IconButton(
                  tooltip: 'Add ${product.name}',
                  onPressed: onAdd,
                  icon: const Icon(Icons.add_circle, color: AppTheme.coral),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: 'Remove one ${product.name}',
                      visualDensity: VisualDensity.compact,
                      onPressed: onRemove,
                      icon: const Icon(Icons.remove_circle_outline, size: 18),
                    ),
                    Text(
                      '$quantity',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    IconButton(
                      tooltip: 'Add ${product.name}',
                      visualDensity: VisualDensity.compact,
                      onPressed: onAdd,
                      icon: const Icon(
                        Icons.add_circle,
                        size: 18,
                        color: AppTheme.coral,
                      ),
                    ),
                  ],
                )
        else
          const StatusPill('OUT TODAY'),
      ],
    ),
  );
}
