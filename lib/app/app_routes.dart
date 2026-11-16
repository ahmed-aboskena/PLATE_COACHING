import 'package:flutter/material.dart';

import '../screens/2d/screen_2d.dart';
import 'screen_registry.dart';

abstract final class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
    '/': (_) => const Screen2D(large: true),
    for (final screen in ScreenRegistry.screens)
      screen.route: (_) => screen.builder(large: true),
  };
}
