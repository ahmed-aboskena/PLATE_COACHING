import 'package:flutter/widgets.dart';

class ClientChatController extends ChangeNotifier {
  ClientChatController() : messageController = TextEditingController();

  final TextEditingController messageController;

  void clear() => messageController.clear();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
