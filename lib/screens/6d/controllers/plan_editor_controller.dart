import 'package:flutter/foundation.dart';

class PlanEditorController extends ChangeNotifier {
  PlanEditorController([List<double>? loads])
    : loads = List<double>.of(loads ?? const [65, 50, 22]);

  final List<double> loads;

  void adjust(int index, double delta) {
    if (index < 0 || index >= loads.length) return;
    loads[index] = (loads[index] + delta).clamp(0, 1000).toDouble();
    notifyListeners();
  }
}
