import 'package:flutter/material.dart';

import 'app_routes.dart';
import 'app_theme.dart';
import '../state/coaching_scope.dart';
import '../state/coaching_state.dart';

class PlateApp extends StatelessWidget {
  const PlateApp({super.key, required this.coachingState});

  final CoachingState coachingState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PLATE Coaching',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      builder: (context, child) =>
          CoachingScope(notifier: coachingState, child: child!),
      routes: AppRoutes.routes,
    );
  }
}
