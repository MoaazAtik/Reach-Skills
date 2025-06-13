import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/ui/auth_screen.dart';
import 'messages_viewmodel.dart';

class MessagesScreen extends StatefulWidget {
  MessagesScreen({super.key, required this.chatId});

  MessagesScreen.fromExplore({
    super.key,
    required this.currentSenderId,
    required this.currentSenderName,
    required this.currentReceiverId,
    required this.currentReceiverName,
  });

  static const String routeName = '/messages';
  static const String title = 'Messages';
  static const IconData icon = Icons.message;

  String? chatId;
  String? currentSenderId;
  String? currentSenderName;
  String? currentReceiverId;
  String? currentReceiverName;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_MessageState');
  final _controller = TextEditingController();

  @override
  void initState() {
    context.read<MessagesViewModel>().updateFields(
      currentSenderId: widget.currentSenderId,
      currentSenderName: widget.currentSenderName,
      currentReceiverId: widget.currentReceiverId,
      currentReceiverName: widget.currentReceiverName,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final messagesViewModel = context.watch<MessagesViewModel>();
    final loggedIn = messagesViewModel.loggedIn;
    final loading = messagesViewModel.loading;

    final messages = messagesViewModel.messages;
    final messagesError = messagesViewModel.messagesError;

    if (!loggedIn) {
      return Column(
        children: [
          const SizedBox(height: 40),
          Text('No user info available.'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const AuthScreen()));
            },
            child: const Text('Sign in'),
          ),
        ],
      );
    }

    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (messagesError != null) {
      return Center(child: Text(messagesError.toString()));
    }

    return Column(
      children: [
        if (messages == null || messages.isEmpty)
          const Center(child: Text('No messages available.'))
        else
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Card(
                  child: ListTile(
                    title: Text(message.content),
                    subtitle: Text(
                      'Sender: ${message.senderName}\nReceiver: ${message.receiverName}',
                    ),
                    trailing: Text(
                      'Updated at: ${DateTime.fromMillisecondsSinceEpoch(message.updatedAt).toString()}',
                    ),
                  ),
                );
              },
            ),
          ),

        const SizedBox(height: 8),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Leave a message',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your message to continue';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.deepPurple),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await context.read<MessagesViewModel>().sendMessage(
                          _controller.text,
                        );
                        _controller.clear();
                      }
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.send),
                        SizedBox(width: 4),
                        Text('SEND'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
