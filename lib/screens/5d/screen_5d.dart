import 'package:flutter/material.dart';

import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';
import 'controllers/client_directory_controller.dart';
import 'widgets/client_directory_widgets.dart';

class Screen5D extends StatefulWidget {
  const Screen5D({this.large = false, super.key});

  final bool large;

  @override
  State<Screen5D> createState() => _Screen5DState();
}

class _Screen5DState extends State<Screen5D> {
  final _controller = ClientDirectoryController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            controller: _controller.queryController,
            onChanged: (_) => _controller.refreshSearch(),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, size: 18),
              hintText: 'Search clients',
              hintStyle: TextStyle(fontSize: 11),
            ),
          ),
          const SizedBox(height: 9),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => ClientFilterChips(
              selected: _controller.filter,
              onSelected: _controller.setFilter,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => Column(
              children: [
                for (final client in _controller.visibleClients)
                  ClientCard(
                    client: client,
                    onTap: () => Navigator.of(context).pushNamed('/6D'),
                  ),
                if (_controller.visibleClients.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(18),
                    child: Center(
                      child: Text(
                        'No clients match this search.',
                        style: TextStyle(
                          color: Color(0xFF6B7886),
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
