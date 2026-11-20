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

@immutable
class BarProduct {
  const BarProduct({
    required this.name,
    required this.description,
    required this.category,
    required this.emoji,
    required this.price,
    this.available = true,
  });

  final String name;
  final String description;
  final String category;
  final String emoji;
  final int price;
  final bool available;
}

@immutable
class BarOrderLine {
  const BarOrderLine({required this.product, required this.quantity});

  final BarProduct product;
  final int quantity;
}

@immutable
class CoachingContact {
  const CoachingContact({
    required this.id,
    required this.name,
    required this.initial,
    required this.type,
    required this.status,
    required this.preview,
  });

  final String id;
  final String name;
  final String initial;
  final String type;
  final String status;
  final String preview;
}

class CoachingState extends ChangeNotifier {
  final List<CoachingContact> _chatContacts = const [
    CoachingContact(
      id: 'client-ahmed',
      name: 'Ahmed M.',
      initial: 'A',
      type: 'Client',
      status: 'Online',
      preview: 'Shoulder feels tight on incline.',
    ),
    CoachingContact(
      id: 'client-sara',
      name: 'Sara K.',
      initial: 'S',
      type: 'Client',
      status: 'Online',
      preview: 'Thanks, I will try the updated plan.',
    ),
    CoachingContact(
      id: 'client-omar',
      name: 'Omar H.',
      initial: 'O',
      type: 'Client',
      status: 'In gym',
      preview: 'Can we review my back session?',
    ),
    CoachingContact(
      id: 'client-nour',
      name: 'Nour A.',
      initial: 'N',
      type: 'Client',
      status: 'Offline',
      preview: 'Video check sent.',
    ),
    CoachingContact(
      id: 'client-youssef',
      name: 'Youssef T.',
      initial: 'Y',
      type: 'Client',
      status: 'In gym',
      preview: 'See you at training.',
    ),
    CoachingContact(
      id: 'coach-khaled',
      name: 'Coach Khaled',
      initial: 'K',
      type: 'Coach',
      status: 'Online',
      preview: 'Are you free to cover my 6 PM session?',
    ),
    CoachingContact(
      id: 'coach-rana',
      name: 'Coach Rana',
      initial: 'R',
      type: 'Coach',
      status: 'Online',
      preview: 'I shared the mobility warm-up.',
    ),
    CoachingContact(
      id: 'coach-hady',
      name: 'Coach Hady',
      initial: 'H',
      type: 'Coach',
      status: 'Busy',
      preview: 'Let us sync after class.',
    ),
    CoachingContact(
      id: 'coach-maya',
      name: 'Coach Maya',
      initial: 'M',
      type: 'Coach',
      status: 'Offline',
      preview: 'Thanks for the program notes.',
    ),
  ];
  final List<BarProduct> _barProducts = const [
    BarProduct(
      name: 'Protein Shake',
      description: 'Chocolate · 30 g protein',
      category: 'Shakes',
      emoji: '🥤',
      price: 70,
    ),
    BarProduct(
      name: 'Banana Oat Shake',
      description: 'Peanut butter',
      category: 'Shakes',
      emoji: '🍌',
      price: 60,
    ),
    BarProduct(
      name: 'Chicken Meal',
      description: 'Rice & vegetables',
      category: 'Meals',
      emoji: '🍗',
      price: 120,
    ),
    BarProduct(
      name: 'Protein Bar',
      description: 'Back at 6 PM',
      category: 'Supplements',
      emoji: '🍫',
      price: 40,
      available: false,
    ),
  ];
  final Map<String, int> _barCart = {};
  List<BarOrderLine>? _barOrder;
  int _barOrderNumber = 213;
  String _barOrderStatus = 'Preparing';

  final List<double> _loads = [65, 50, 22];
  final Map<String, double> _coachExerciseLoads = {
    'Bench Press': 60,
    'Shoulder Press': 30,
    'Barbell Row': 50,
    'Lat Pulldown': 45,
    'Squat': 80,
    'Romanian Deadlift': 60,
  };
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
  late final Map<String, List<CoachingMessage>> _conversations = {
    'client-ahmed': _clientMessages,
    'client-sara': [
      const CoachingMessage(
        text: 'How did the new leg plan feel?',
        fromCoach: true,
      ),
      const CoachingMessage(
        text: 'Thanks, I will try the updated plan.',
        fromCoach: false,
      ),
    ],
    'client-omar': [
      const CoachingMessage(
        text: 'Can we review my back session?',
        fromCoach: false,
      ),
    ],
    'client-nour': [
      const CoachingMessage(text: 'Video check sent.', fromCoach: false),
    ],
    'client-youssef': [
      const CoachingMessage(text: 'See you at training.', fromCoach: false),
    ],
    'coach-khaled': [
      const CoachingMessage(
        text: 'Are you free to cover my 6 PM session?',
        fromCoach: false,
      ),
    ],
    'coach-rana': [
      const CoachingMessage(
        text: 'I shared the mobility warm-up.',
        fromCoach: false,
      ),
    ],
    'coach-hady': [
      const CoachingMessage(text: 'Let us sync after class.', fromCoach: false),
    ],
    'coach-maya': [
      const CoachingMessage(
        text: 'Thanks for the program notes.',
        fromCoach: false,
      ),
    ],
  };

  String _bookingType = 'Video';
  String _bookingDay = 'Today';
  String _bookingTime = '7:30 PM';
  bool _acceptingBookings = true;
  String? _requestDecision;

  List<double> get loads => List.unmodifiable(_loads);
  List<CoachingContact> get chatContacts => List.unmodifiable(_chatContacts);
  Map<String, double> get coachExerciseLoads =>
      Map.unmodifiable(_coachExerciseLoads);
  List<CoachingMessage> get memberMessages =>
      List.unmodifiable(_memberMessages);
  List<CoachingMessage> get clientMessages =>
      List.unmodifiable(_clientMessages);
  String get bookingType => _bookingType;
  String get bookingDay => _bookingDay;
  String get bookingTime => _bookingTime;
  bool get acceptingBookings => _acceptingBookings;
  String? get requestDecision => _requestDecision;
  List<BarProduct> get barProducts => List.unmodifiable(_barProducts);
  List<BarOrderLine> get barCart => [
    for (final product in _barProducts)
      if ((_barCart[product.name] ?? 0) > 0)
        BarOrderLine(product: product, quantity: _barCart[product.name]!),
  ];
  List<BarOrderLine>? get barOrder =>
      _barOrder == null ? null : List.unmodifiable(_barOrder!);
  int get barCartCount => _barCart.values.fold(0, (sum, count) => sum + count);
  int get barCartTotal =>
      barCart.fold(0, (sum, line) => sum + line.product.price * line.quantity);
  int get barOrderNumber => _barOrderNumber;
  int get barOrderTotal => _barOrder == null
      ? 0
      : _barOrder!.fold(
          0,
          (sum, line) => sum + line.product.price * line.quantity,
        );
  String get barOrderStatus => _barOrderStatus;

  List<CoachingMessage> conversationMessages(String contactId) =>
      List.unmodifiable(_conversations[contactId] ?? const []);

  void addConversationMessage(String contactId, String text) {
    final trimmed = text.trim();
    final messages = _conversations[contactId];
    if (trimmed.isEmpty || messages == null) return;
    messages.add(CoachingMessage(text: trimmed, fromCoach: true));
    notifyListeners();
  }

  void addBarProduct(BarProduct product) {
    if (!product.available) return;
    _barCart.update(
      product.name,
      (quantity) => quantity + 1,
      ifAbsent: () => 1,
    );
    notifyListeners();
  }

  void changeBarQuantity(BarProduct product, int delta) {
    final quantity = (_barCart[product.name] ?? 0) + delta;
    if (quantity <= 0) {
      _barCart.remove(product.name);
    } else {
      _barCart[product.name] = quantity;
    }
    notifyListeners();
  }

  bool reserveBarOrder() {
    if (_barCart.isEmpty) return false;
    _barOrder = barCart;
    _barCart.clear();
    _barOrderNumber++;
    _barOrderStatus = 'Preparing';
    notifyListeners();
    return true;
  }

  void cancelBarOrder() {
    _barOrder = null;
    notifyListeners();
  }

  void advanceBarOrder() {
    _barOrderStatus = switch (_barOrderStatus) {
      'Placed' => 'Preparing',
      'Preparing' => 'Ready for pickup',
      'Ready for pickup' => 'Picked up',
      _ => 'Picked up',
    };
    notifyListeners();
  }

  void adjustLoad(int index, double delta) {
    if (index < 0 || index >= _loads.length) return;
    _loads[index] = (_loads[index] + delta).clamp(0, 1000).toDouble();
    notifyListeners();
  }

  void adjustCoachExerciseLoad(String exercise, double delta) {
    final current = _coachExerciseLoads[exercise];
    if (current == null) return;
    _coachExerciseLoads[exercise] = (current + delta).clamp(0, 1000).toDouble();
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
