import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import 'coaching_widgets.dart';

class PhoneMockup extends StatelessWidget {
  const PhoneMockup({
    required this.screenId,
    required this.title,
    required this.child,
    this.large = false,
    this.hideNavigation = false,
    super.key,
  });

  final String screenId;
  final String title;
  final Widget child;
  final bool large;
  final bool hideNavigation;

  @override
  Widget build(BuildContext context) {
    final isMember =
        screenId == '8A' || const {'1D', '2D', '3D'}.contains(screenId);
    final activeRoute = switch (screenId) {
      '8A' => '/8A',
      '1D' || '2D' || '3D' => '/8A',
      '4D' => '/4D',
      '5D' || '6D' => '/5D',
      '7D' || '8D' => '/7D',
      '9D' => '/9D',
      '10D' => '/10D',
      'coach-bar' || 'coach-order' => '/coach-bar',
      'coach-train' => '/coach-train',
      _ => '/$screenId',
    };

    if (large) {
      return Scaffold(
        key: ValueKey('screen-$screenId'),
        backgroundColor: AppTheme.paleTeal,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: SizedBox.expand(
                child: Column(
                  children: [
                    _statusBar(),
                    Expanded(child: _screenBody()),
                    if (!hideNavigation && screenId != '1D')
                      _navigationBar(context, isMember, activeRoute),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      width: 270,
      height: 560,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: const [
          BoxShadow(
            color: Color(0x28305A58),
            blurRadius: 32,
            offset: Offset(0, 18),
          ),
          BoxShadow(color: Colors.white, spreadRadius: 1),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: Column(
          children: [
            _statusBar(),
            Expanded(child: _screenBody()),
            if (!hideNavigation && screenId != '1D')
              _navigationBar(context, isMember, activeRoute),
          ],
        ),
      ),
    );
  }

  Widget _statusBar() => Container(
    height: 26,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    color: const Color(0xFFB6EBE2),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '9:41',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
        ),
        Text('●●●', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700)),
      ],
    ),
  );

  Widget _screenBody() => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFB6EBE2), Color(0xFFCDF1EA), AppTheme.paleTeal],
        stops: [0, 0.22, 1],
      ),
    ),
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      child: child,
    ),
  );

  Widget _navigationBar(
    BuildContext context,
    bool isMember,
    String activeRoute,
  ) => Container(
    height: 56,
    decoration: const BoxDecoration(
      color: Colors.white,
      border: Border(top: BorderSide(color: AppTheme.line)),
    ),
    child: Row(
      children: isMember
          ? [
              Expanded(
                child: _nav(
                  context,
                  Icons.home_outlined,
                  'Home',
                  '/2D',
                  activeRoute,
                ),
              ),
              Expanded(
                child: _nav(
                  context,
                  Icons.fitness_center,
                  'Train',
                  '/2D',
                  activeRoute,
                ),
              ),
              Expanded(
                child: _nav(
                  context,
                  Icons.local_cafe,
                  'Bar',
                  '/2D',
                  activeRoute,
                ),
              ),
              Expanded(
                child: _nav(
                  context,
                  Icons.person_outline,
                  'Coach',
                  '/8A',
                  activeRoute,
                ),
              ),
              Expanded(
                child: _nav(
                  context,
                  Icons.settings_outlined,
                  'Profile',
                  '/10D',
                  activeRoute,
                ),
              ),
            ]
          : [
              Expanded(
                child: _nav(
                  context,
                  Icons.home_outlined,
                  'Home',
                  '/4D',
                  activeRoute,
                ),
              ),
              Expanded(
                child: _nav(
                  context,
                  Icons.people_outline,
                  'Clients',
                  '/5D',
                  activeRoute,
                ),
              ),
              Expanded(
                child: _nav(
                  context,
                  Icons.chat_bubble_outline,
                  'Chat',
                  '/7D',
                  activeRoute,
                ),
              ),
              Expanded(
                child: _nav(
                  context,
                  Icons.local_cafe_outlined,
                  'Bar',
                  '/coach-bar',
                  activeRoute,
                ),
              ),
              Expanded(
                child: _nav(
                  context,
                  Icons.person_outline,
                  'Profile',
                  '/10D',
                  activeRoute,
                ),
              ),
            ],
    ),
  );

  Widget _nav(
    BuildContext context,
    IconData icon,
    String label,
    String route,
    String activeRoute,
  ) => ScreenNavButton(
    icon: icon,
    label: label,
    route: route,
    selected: activeRoute == route,
  );
}
