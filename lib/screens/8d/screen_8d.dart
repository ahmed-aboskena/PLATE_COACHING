import 'package:flutter/material.dart';

import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';
import 'controllers/coach_directory_controller.dart';
import 'widgets/coach_directory_widgets.dart';

class Screen8D extends StatefulWidget {
  const Screen8D({this.large = false, super.key});

  final bool large;

  @override
  State<Screen8D> createState() => _Screen8DState();
}

class _Screen8DState extends State<Screen8D> {
  final _controller = CoachDirectoryController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhoneMockup(
      screenId: '8D',
      title: 'Coaches',
      large: widget.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenHeading('Coaches', trailing: StatusPill('COACH')),
          TextField(
            controller: _controller.queryController,
            onChanged: (_) => setState(() => _controller.refreshSearch()),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, size: 18),
              hintText: 'Search coaches',
              hintStyle: TextStyle(fontSize: 11),
            ),
          ),
          const SizedBox(height: 10),
          for (final coach in _controller.visibleCoaches)
            CoachDirectoryCard(
              coach: coach,
              onMessage: () =>
                  Navigator.of(context).pushNamed('/7D', arguments: coach.name),
            ),
          if (_controller.visibleCoaches.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'No coaches found.',
                  style: TextStyle(color: Color(0xFF6B7886), fontSize: 11),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
