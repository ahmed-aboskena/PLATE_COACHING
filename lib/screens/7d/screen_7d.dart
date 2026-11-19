import 'package:flutter/material.dart';

import '../../state/coaching_scope.dart';
import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';
import 'controllers/client_chat_controller.dart';
import 'widgets/client_chat_widgets.dart';

class Screen7D extends StatefulWidget {
  const Screen7D({this.large = false, super.key});

  final bool large;

  @override
  State<Screen7D> createState() => _Screen7DState();
}

class _Screen7DState extends State<Screen7D> {
  final _controller = ClientChatController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send([String? suggestion]) {
    final text = suggestion ?? _controller.messageController.text;
    if (text.trim().isEmpty) {
      showAppNotice(context, 'Type a message first.');
      return;
    }
    CoachingScope.of(context).addClientMessage(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final state = CoachingScope.of(context);
    return PhoneMockup(
      screenId: '7D',
      title: 'Chat with client',
      large: widget.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ChatHeader(),
          const Divider(height: 15, color: Color(0xFFE3ECEA)),
          for (final message in state.clientMessages)
            if (message.callNote)
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6F3EC),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    message.text,
                    style: const TextStyle(
                      color: Color(0xFF1F9A85),
                      fontSize: 9,
                    ),
                  ),
                ),
              )
            else
              Align(
                alignment: message.fromCoach
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 216),
                  margin: const EdgeInsets.only(bottom: 7),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: message.fromCoach
                        ? const Color(0xFFF4877B)
                        : Colors.white,
                    border: message.fromCoach
                        ? null
                        : Border.all(color: const Color(0xFFE3ECEA)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: message.fromCoach ? Colors.white : null,
                      fontSize: 10,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Wrap(
              spacing: 5,
              children: [
                ChatQuickReply(
                  label: 'Send plan',
                  onPressed: () => _send('Here is your updated plan.'),
                ),
                ChatQuickReply(
                  label: 'Ask for video',
                  onPressed: () => _send('Can you send a form-check video?'),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller.messageController,
                  onSubmitted: (_) => _send(),
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                      color: Color(0xFF6B7886),
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              IconButton.filled(
                onPressed: _send,
                tooltip: 'Send message',
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFFF4877B),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.arrow_upward, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
