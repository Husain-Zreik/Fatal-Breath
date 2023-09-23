import 'package:fatal_breath_frontend/models/message.model.dart';
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
  Widget build(BuildContext context) => Align(
        alignment: isMe ? Alignment.topLeft : Alignment.topRight,
        child: Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.red[200] : Colors.grey,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
          ),
          margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Text(message.content,
                  style: const TextStyle(color: Colors.white)),
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
      );

  // _chatBubble(Message message, bool isMe) {
  //   if (!isMe) {
  //     return Container(
  //       alignment: Alignment.topLeft,
  //       child: Container(
  //         constraints: BoxConstraints(
  //             maxWidth: MediaQuery.of(context).size.width * 0.70),
  //         child: Container(
  //             padding: const EdgeInsets.all(10),
  //             margin: const EdgeInsets.symmetric(vertical: 10),
  //             decoration: const BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.zero,
  //                   topRight: Radius.circular(20),
  //                   bottomLeft: Radius.circular(20),
  //                   bottomRight: Radius.circular(20)),
  //             ),
  //             child: Text(message.content)),
  //       ),
  //     );
  //   } else {
  //     return Container(
  //       alignment: Alignment.topRight,
  //       child: Container(
  //         constraints: BoxConstraints(
  //             maxWidth: MediaQuery.of(context).size.width * 0.70),
  //         child: Container(
  //             padding: const EdgeInsets.all(10),
  //             margin: const EdgeInsets.symmetric(vertical: 10),
  //             decoration: const BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.only(
  //                   topRight: Radius.zero,
  //                   topLeft: Radius.circular(20),
  //                   bottomLeft: Radius.circular(20),
  //                   bottomRight: Radius.circular(20)),
  //             ),
  //             child: Text(message.content)),
  //       ),
  //     );
  //   }
  // }
}
