import 'package:flutter/widgets.dart';

import '../models/client_model.dart';

class ClientDirectoryController extends ChangeNotifier {
  ClientDirectoryController() : queryController = TextEditingController();

  final TextEditingController queryController;
  String filter = 'All 12';

  static const clients = <ClientModel>[
    ClientModel(
      initial: 'A',
      name: 'Ahmed M.',
      activity: 'Chest day · 2h ago',
      status: 'In gym',
      badge: '2',
    ),
    ClientModel(
      initial: 'S',
      name: 'Sara K.',
      activity: 'Legs',
      status: 'Online',
      badge: '1',
    ),
    ClientModel(
      initial: 'O',
      name: 'Omar H.',
      activity: 'Back · yesterday',
      status: 'In gym',
      badge: '',
    ),
    ClientModel(
      initial: 'N',
      name: 'Nour A.',
      activity: 'Shoulders · 3 days ago',
      status: 'Online',
      badge: '',
    ),
    ClientModel(
      initial: 'Y',
      name: 'Youssef T.',
      activity: 'Legs · 4 days ago',
      status: 'In gym',
      badge: '',
    ),
  ];

  List<ClientModel> get visibleClients {
    final query = queryController.text.trim().toLowerCase();
    return clients.where((client) {
      final matchesName =
          query.isEmpty || client.name.toLowerCase().contains(query);
      final matchesFilter = switch (filter) {
        'Online 5' => client.status == 'Online',
        'In gym 7' => client.status == 'In gym',
        _ => true,
      };
      return matchesName && matchesFilter;
    }).toList();
  }

  void setFilter(String value) {
    if (filter == value) return;
    filter = value;
    notifyListeners();
  }

  void refreshSearch() => notifyListeners();

  @override
  void dispose() {
    queryController.dispose();
    super.dispose();
  }
}
