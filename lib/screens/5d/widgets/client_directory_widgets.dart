import 'package:flutter/material.dart';

import '../../../widgets/coaching_widgets.dart';
import '../models/client_model.dart';

class ClientFilterChips extends StatelessWidget {
  const ClientFilterChips({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 5,
    children: [
      for (final filter in const ['All 12', 'Online 5', 'In gym 7'])
        ChoiceChip(
          label: Text(
            filter,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
          ),
          selected: selected == filter,
          onSelected: (_) => onSelected(filter),
          visualDensity: VisualDensity.compact,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          selectedColor: const Color(0xFF5FD0BF),
          backgroundColor: Colors.white,
          labelStyle: TextStyle(
            color: selected == filter ? Colors.white : const Color(0xFF6B7886),
          ),
          side: const BorderSide(color: Color(0xFFE3ECEA)),
        ),
    ],
  );
}

class ClientCard extends StatelessWidget {
  const ClientCard({required this.client, required this.onTap, super.key});

  final ClientModel client;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: UiCard(
      padding: const EdgeInsets.all(9),
      margin: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          AvatarBadge(client.initial, small: true),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client.name,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Color(0xFF6B7886),
                      fontSize: 9,
                    ),
                    children: [
                      TextSpan(text: client.activity),
                      if (client.status == 'Online')
                        const TextSpan(
                          text: ' · ',
                          children: [
                            TextSpan(
                              text: '● Online',
                              style: TextStyle(
                                color: Color(0xFF1F9A85),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (client.badge.isNotEmpty)
            Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFFD6F3EC),
                shape: BoxShape.circle,
              ),
              child: Text(
                client.badge,
                style: const TextStyle(
                  color: Color(0xFF1F9A85),
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
