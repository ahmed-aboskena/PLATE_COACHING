import 'package:flutter/foundation.dart';

class BookingController extends ChangeNotifier {
  String type = 'Video';
  String day = 'Today';
  String time = '7:30 PM';

  void setType(String value) {
    if (type == value) return;
    type = value;
    notifyListeners();
  }

  void setDay(String value) {
    if (day == value) return;
    day = value;
    notifyListeners();
  }

  void setTime(String value) {
    if (time == value) return;
    time = value;
    notifyListeners();
  }
}
