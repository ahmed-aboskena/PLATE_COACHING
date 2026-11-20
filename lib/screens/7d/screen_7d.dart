import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../state/coaching_scope.dart';
import '../../state/coaching_state.dart';
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
  final _searchController = TextEditingController();
  String _filter = 'All';
  String? _selectedConversationId;
  bool _routeArgumentRead = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_routeArgumentRead) return;
    _routeArgumentRead = true;
    final argument = ModalRoute.of(context)?.settings.arguments;
    if (argument is String) {
      final contact = CoachingScope.of(context).chatContacts
          .where((item) => item.name == argument || item.id == argument)
          .firstOrNull;
      _selectedConversationId = contact?.id;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _send(CoachingState state, String contactId, [String? suggestion]) {
    final text = suggestion ?? _controller.messageController.text;
    if (text.trim().isEmpty) {
      showAppNotice(context, 'Type a message first.');
      return;
    }
    state.addConversationMessage(contactId, text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final state = CoachingScope.of(context);
    final contact = state.chatContacts
        .where((item) => item.id == _selectedConversationId)
        .firstOrNull;

    return PhoneMockup(
      screenId: '7D',
      title: contact == null ? 'Chats' : 'Chat with ${contact.name}',
      large: widget.large,
      child: contact == null ? _inbox(state) : _conversation(state, contact),
    );
  }

  Widget _inbox(CoachingState state) {
    final query = _searchController.text.trim().toLowerCase();
    final contacts = state.chatContacts.where((contact) {
      final matchesType = _filter == 'All' || contact.type == _filter;
      final matchesQuery =
          query.isEmpty ||
          '${contact.name} ${contact.preview}'.toLowerCase().contains(query);
      return matchesType && matchesQuery;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ScreenHeading(
          'Chats',
          eyebrow: 'Clients and coaching team',
          trailing: StatusPill('COACH'),
        ),
        TextField(
          controller: _searchController,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search, size: 18),
            hintText: 'Search conversations',
            hintStyle: TextStyle(fontSize: 11),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          children: [
            for (final filter in const ['All', 'Clients', 'Coaches'])
              ChoiceChip(
                label: Text(filter),
                selected: _filter == filter,
                onSelected: (_) => setState(() => _filter = filter),
              ),
          ],
        ),
        const SizedBox(height: 6),
        for (final person in contacts)
          _ConversationTile(
            contact: person,
            preview:
                state.conversationMessages(person.id).lastOrNull?.text ??
                person.preview,
            onTap: () => setState(() => _selectedConversationId = person.id),
          ),
        if (contacts.isEmpty)
          const Padding(
            padding: EdgeInsets.all(18),
            child: Center(
              child: Text(
                'No conversations found.',
                style: TextStyle(color: AppTheme.mute, fontSize: 11),
              ),
            ),
          ),
      ],
    );
  }

  Widget _conversation(CoachingState state, CoachingContact contact) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ChatHeader(
        contact: contact,
        onBack: () => setState(() => _selectedConversationId = null),
      ),
      const Divider(height: 15, color: AppTheme.line),
      for (final message in state.conversationMessages(contact.id))
        if (message.callNote)
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFD6F3EC),
                borderRadius: BorderRadius.circular(99),
              ),
              child: Text(
                message.text,
                style: const TextStyle(color: AppTheme.teal, fontSize: 9),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: message.fromCoach ? AppTheme.coral : Colors.white,
                border: message.fromCoach
                    ? null
                    : Border.all(color: AppTheme.line),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.fromCoach ? Colors.white : AppTheme.ink,
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
              onPressed: () =>
                  _send(state, contact.id, 'Here is your updated plan.'),
            ),
            ChatQuickReply(
              label: 'Ask for video',
              onPressed: () =>
                  _send(state, contact.id, 'Can you send a form-check video?'),
            ),
          ],
        ),
      ),
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller.messageController,
              onSubmitted: (_) => _send(state, contact.id),
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(color: AppTheme.mute, fontSize: 10),
              ),
            ),
          ),
          const SizedBox(width: 5),
          IconButton.filled(
            onPressed: () => _send(state, contact.id),
            tooltip: 'Send message',
            style: IconButton.styleFrom(
              backgroundColor: AppTheme.coral,
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_upward, size: 18),
          ),
        ],
      ),
    ],
  );
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({
    required this.contact,
    required this.preview,
    required this.onTap,
  });

  final CoachingContact contact;
  final String preview;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: UiCard(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      margin: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          AvatarBadge(contact.initial, small: true),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        contact.name,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      contact.type,
                      style: const TextStyle(color: AppTheme.mute, fontSize: 9),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  preview,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppTheme.mute, fontSize: 9),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          Icon(
            contact.status == 'Online' ? Icons.circle : Icons.circle_outlined,
            size: 8,
            color: contact.status == 'Online' ? AppTheme.teal : AppTheme.mute,
          ),
        ],
      ),
    ),
  );
}
