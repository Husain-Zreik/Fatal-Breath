import 'package:fatal_breath_frontend/models/message.model.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.isMe,
    required this.message,
  });

  final bool isMe;
  final Message message;

  @override
  Widget build(BuildContext context) => Container(
        alignment: !isMe ? Alignment.topLeft : Alignment.topRight,
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.80),
          child: Container(
            decoration: BoxDecoration(
              color: isMe
                  ? const Color.fromARGB(255, 161, 0, 0)
                  : GlobalColors.mainColor,
              borderRadius: !isMe
                  ? const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
            ),
            margin:
                const EdgeInsets.only(top: 5, right: 10, left: 10, bottom: 5),
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(message.content,
                    style: const TextStyle(color: Colors.white, fontSize: 15)),
                const SizedBox(height: 5),
                Text(
                  timeago.format(message.sentTime),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
