import 'package:fatal_breath_frontend/providers/firebase.provider.dart';
import 'package:fatal_breath_frontend/widgets/message.bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key, required this.receiverId});
  final int receiverId;

  @override
  Widget build(BuildContext context) => Consumer<FirebaseProvider>(
        builder: (context, value, child) => Expanded(
          child: ListView.builder(
            controller: Provider.of<FirebaseProvider>(context, listen: false)
                .scrollController,
            itemCount: value.messages.length,
            itemBuilder: (context, index) {
              final isMe = receiverId != value.messages[index].senderId;

              return MessageBubble(
                isMe: isMe,
                message: value.messages[index],
              );
            },
          ),
        ),
      );
}
