import 'package:flutter/material.dart';

import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';

class Screen5D extends StatefulWidget {
  const Screen5D({this.large = false, super.key});

  final bool large;

  @override
  State<Screen5D> createState() => _Screen5DState();
}

class _Screen5DState extends State<Screen5D> {
  final _queryController = TextEditingController();
  String _filter = 'All 12';

  static const _clients = [
    ('A', 'Ahmed M.', 'Chest day · 2h ago', 'In gym', '2'),
    ('S', 'Sara K.', 'Legs · Online', 'Online', '1'),
    ('O', 'Omar H.', 'Back · yesterday', 'In gym', ''),
    ('N', 'Nour A.', 'Shoulders · 3 days ago', 'Online', ''),
    ('Y', 'Youssef T.', 'Legs · 4 days ago', 'In gym', ''),
  ];

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _queryController.text.toLowerCase();
    final visible = _clients.where((client) {
      final matchesName = client.$2.toLowerCase().contains(query);
      final matchesFilter = _filter == 'All 12' || _filter == client.$4;
      return matchesName && matchesFilter;
    }).toList();

    return PhoneMockup(
      screenId: '5D',
      title: 'Clients',
      large: widget.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeading(
            'Clients',
            trailing: IconButton(
              tooltip: 'Invite a client',
              onPressed: () =>
                  showAppNotice(context, 'New client invitation created'),
              icon: const Icon(Icons.add, size: 21),
            ),
          ),
          TextField(
            controller: _queryController,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, size: 18),
              hintText: 'Search clients',
              hintStyle: TextStyle(fontSize: 11),
            ),
          ),
          const SizedBox(height: 9),
          Wrap(
            spacing: 5,
            children: [
              for (final filter in ['All 12', 'Online', 'In gym'])
                ChoiceChip(
                  label: Text(
                    filter,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selected: _filter == filter,
                  onSelected: (_) => setState(() => _filter = filter),
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  selectedColor: const Color(0xFF5FD0BF),
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: _filter == filter
                        ? Colors.white
                        : const Color(0xFF6B7886),
                  ),
                  side: const BorderSide(color: Color(0xFFE3ECEA)),
                ),
            ],
          ),
          const SizedBox(height: 4),
          for (final client in visible)
            InkWell(
              onTap: () => Navigator.of(context).pushNamed('/6D'),
              borderRadius: BorderRadius.circular(16),
              child: UiCard(
                padding: const EdgeInsets.all(9),
                margin: const EdgeInsets.only(bottom: 7),
                child: Row(
                  children: [
                    AvatarBadge(client.$1, small: true),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            client.$2,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            client.$3,
                            style: const TextStyle(
                              color: Color(0xFF6B7886),
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (client.$5.isNotEmpty)
                      Container(
                        width: 20,
                        height: 20,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD6F3EC),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          client.$5,
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
            ),
          if (visible.isEmpty)
            const Padding(
              padding: EdgeInsets.all(18),
              child: Center(
                child: Text(
                  'No clients match this search.',
                  style: TextStyle(color: Color(0xFF6B7886), fontSize: 11),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
