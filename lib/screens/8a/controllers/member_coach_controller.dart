import 'package:flutter/widgets.dart';

class MemberCoachController extends ChangeNotifier {
  MemberCoachController() : messageController = TextEditingController();

  final TextEditingController messageController;

  void clear() => messageController.clear();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
