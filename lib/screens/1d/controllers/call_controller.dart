import 'package:flutter/foundation.dart';

class CallController extends ChangeNotifier {
  String mode = 'Video';
  bool muted = false;
  bool cameraOn = true;

  void setMode(String value) {
    if (mode == value) return;
    mode = value;
    notifyListeners();
  }

  void toggleMuted() {
    muted = !muted;
    notifyListeners();
  }

  void toggleCamera() {
    cameraOn = !cameraOn;
    notifyListeners();
  }
}
