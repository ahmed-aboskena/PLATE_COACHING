import 'package:flutter/widgets.dart';

import '../models/coach_directory_model.dart';

class CoachDirectoryController extends ChangeNotifier {
  CoachDirectoryController() : queryController = TextEditingController();

  final TextEditingController queryController;

  static const coaches = [
    CoachDirectoryModel(
      initial: 'K',
      name: 'Coach Khaled',
      specialty: 'Strength',
      status: 'Online',
    ),
    CoachDirectoryModel(
      initial: 'R',
      name: 'Coach Rana',
      specialty: 'Mobility',
      status: 'Online',
    ),
    CoachDirectoryModel(
      initial: 'H',
      name: 'Coach Hady',
      specialty: 'CrossFit',
      status: 'Busy',
    ),
    CoachDirectoryModel(
      initial: 'M',
      name: 'Coach Maya',
      specialty: 'Yoga',
      status: 'Offline',
    ),
  ];

  List<CoachDirectoryModel> get visibleCoaches {
    final query = queryController.text.trim().toLowerCase();
    if (query.isEmpty) return coaches;
    return coaches.where((coach) {
      return '${coach.name} ${coach.specialty}'.toLowerCase().contains(query);
    }).toList();
  }

  void refreshSearch() => notifyListeners();

  @override
  void dispose() {
    queryController.dispose();
    super.dispose();
  }
}
