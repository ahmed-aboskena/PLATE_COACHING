import 'package:flutter/foundation.dart';

class CoachBookingController extends ChangeNotifier {
  bool acceptingBookings = true;
  String? requestDecision;

  void toggleBookings() {
    acceptingBookings = !acceptingBookings;
    notifyListeners();
  }

  void decideRequest(String decision) {
    requestDecision = decision;
    notifyListeners();
  }
}
