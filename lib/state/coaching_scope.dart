import 'package:flutter/widgets.dart';

import 'coaching_state.dart';

class CoachingScope extends InheritedNotifier<CoachingState> {
  const CoachingScope({
    required CoachingState notifier,
    required super.child,
    super.key,
  }) : super(notifier: notifier);

  static CoachingState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CoachingScope>();
    assert(scope != null, 'CoachingScope is missing from the widget tree.');
    return scope!.notifier!;
  }
}
