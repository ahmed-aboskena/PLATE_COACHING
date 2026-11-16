import 'package:flutter/foundation.dart';

@immutable
class CoachingMessage {
  const CoachingMessage({
    required this.text,
    required this.fromCoach,
    this.callNote = false,
  });

  final String text;
  final bool fromCoach;
  final bool callNote;
}

class CoachingState extends ChangeNotifier {
  final List<double> _loads = [65, 50, 22];
  final List<CoachingMessage> _memberMessages = [
    const CoachingMessage(
      text: 'Nice work today. Add 2.5 kg next week if the last set felt easy.',
      fromCoach: true,
    ),
    const CoachingMessage(
      text: 'My shoulder feels tight on incline.',
      fromCoach: false,
    ),
    const CoachingMessage(
      text: 'Drop 2 kg and send me one set on video.',
      fromCoach: true,
    ),
  ];

  final List<CoachingMessage> _clientMessages = [
    const CoachingMessage(
      text: 'Shoulder feels tight on incline.',
      fromCoach: false,
    ),
    const CoachingMessage(
      text: 'Drop 2 kg and send me one set on video.',
      fromCoach: true,
    ),
    const CoachingMessage(text: '▶ Form check · 0:24', fromCoach: false),
    const CoachingMessage(
      text: '☎ Voice call · 6 min',
      fromCoach: false,
      callNote: true,
    ),
    const CoachingMessage(
      text: 'Looks good. Keep elbows tucked. Plan updated ✓',
      fromCoach: true,
    ),
  ];

  String _bookingType = 'Video';
  String _bookingDay = 'Today';
  String _bookingTime = '7:30 PM';
  bool _acceptingBookings = true;
  String? _requestDecision;

  List<double> get loads => List.unmodifiable(_loads);
  List<CoachingMessage> get memberMessages =>
      List.unmodifiable(_memberMessages);
  List<CoachingMessage> get clientMessages =>
      List.unmodifiable(_clientMessages);
  String get bookingType => _bookingType;
  String get bookingDay => _bookingDay;
  String get bookingTime => _bookingTime;
  bool get acceptingBookings => _acceptingBookings;
  String? get requestDecision => _requestDecision;

  void adjustLoad(int index, double delta) {
    if (index < 0 || index >= _loads.length) return;
    _loads[index] = (_loads[index] + delta).clamp(0, 1000).toDouble();
    notifyListeners();
  }

  void addMemberMessage(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    _memberMessages.add(CoachingMessage(text: trimmed, fromCoach: false));
    notifyListeners();
  }

  void addClientMessage(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    _clientMessages.add(CoachingMessage(text: trimmed, fromCoach: true));
    notifyListeners();
  }

  void setBookingType(String value) {
    _bookingType = value;
    notifyListeners();
  }

  void setBookingDay(String value) {
    _bookingDay = value;
    notifyListeners();
  }

  void setBookingTime(String value) {
    _bookingTime = value;
    notifyListeners();
  }

  void toggleBookings() {
    _acceptingBookings = !_acceptingBookings;
    notifyListeners();
  }

  void decideRequest(String decision) {
    _requestDecision = decision;
    notifyListeners();
  }
}
