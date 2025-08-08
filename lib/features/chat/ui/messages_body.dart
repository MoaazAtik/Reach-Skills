import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/core/utils/utils.dart';
import 'package:reach_skills/features/chat/ui/message_tile.dart';

import '../../../core/constants/strings.dart';
import '../../../core/theme/styles.dart';
import 'messages_viewmodel.dart';

class MessagesBody extends StatefulWidget {
  final VoidCallback onSignInPressed;

  const MessagesBody({super.key, required this.onSignInPressed});

  @override
  State<MessagesBody> createState() => _MessagesBodyState();
}

class _MessagesBodyState extends State<MessagesBody> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_MessageState');
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    registerScrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final messagesViewModel = context.watch<MessagesViewModel>();
    final isLoggedIn = messagesViewModel.isLoggedIn;
    final loading = messagesViewModel.loading;
    final currentSenderName = messagesViewModel.currentSenderName;

    final messages = messagesViewModel.messages?.reversed.toList();
    final messagesError = messagesViewModel.messagesError;

    if (!isLoggedIn) {
      return Column(
        children: [
          const SizedBox(height: 40),
          Text(Str.noUserInfoMessage),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: widget.onSignInPressed,
            child: const Text(Str.signIn),
          ),
        ],
      );
    }

    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (messagesError != null) {
      return Center(child: Text(messagesError));
    }

    return Column(
      children: [
        // No Messages Widget
        if (messages == null || messages.isEmpty)
          const Center(child: Text(Str.noMessagesMessage))
        else
          // Messages List
          Expanded(
            child: ListView.builder(
              // Todo remove mock comments
              // itemCount: 10,
              // reverse: true, // I reversed the `messages` instead
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                registerScrollToBottom();

                final message = messages[index];
                return MessageTile(
                  // Todo remove mock comments
                  // messageContent:
                  // index % 2 == 0 ? Str.mockMessage3 : Str.mockMessage4,
                  // senderName: index % 2 == 0 ? Str.mockUserName : Str.
                  // mockUserName2,
                  // currentUserName: Str.mockUserName,
                  messageContent: message.content,
                  senderName: message.senderName,
                  currentUserName: currentSenderName ?? '',
                  // Todo add timestamp 'message.updatedAt'
                );
              },
            ),
          ),

        const SizedBox(height: Styles.spacingSmall),

        // Padding(
        //   padding: const EdgeInsets.all(Styles.paddingSmall),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Styles.borderRadius),
          ),
          color: Styles.rsDefaultSurfaceColor,
          elevation: Styles.elevationCard,
          child: Form(
            key: _formKey,
            child: SizedBox(
              /*
              `Styles.paddingMedium * 2` represents RsChip's
               paddingLeft and paddingRight.
              */
              width:
                  MediaQuery.sizeOf(context).width - (Styles.paddingMedium * 2),
              child: Row(
                children: [
                  // Message Input
                  Expanded(
                    child: TextFormField(
                      decoration: Styles.rsInputDecoration(
                        hint: Str.messageHint,
                        // Todo enhance this coloring
                        fillColor: Styles.dialogBackgroundColor,
                        // fillColor: Styles.skillChipBackgroundColor,
                        // fillColor: Styles.buttonFullBackgroundColor,
                      ),
                      controller: _messageController,
                      validator:
                          (value) => textValidator(
                            value,
                            errorMessage: Str.emptyMessageError,
                          ),
                      minLines: 1,
                      maxLines: 6,
                    ),
                  ),
                  const SizedBox(width: Styles.spacingSmall),

                  // Send Button
                  OutlinedButton(
                    style: Styles.styleOutlineButton,
                    // Todo implement onPressed
                    onPressed: () async {
                      if (_formKey.currentState == null ||
                          !_formKey.currentState!.validate()) {
                        return;
                      }

                      await context.read<MessagesViewModel>().sendMessage(
                        _messageController.text.trim(),
                      );
                      _messageController.clear();
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.send),
                        SizedBox(width: Styles.spacingExtraSmall),
                        Text(Str.send),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: Styles.spacingSmall),
      ],
    );
  }

  void registerScrollToBottom() {
    if (!_scrollController.hasClients) return;

    WidgetsBinding.instance.addPostFrameCallback(
      (duration) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
