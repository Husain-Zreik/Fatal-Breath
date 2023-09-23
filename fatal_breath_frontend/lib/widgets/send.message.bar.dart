import 'package:fatal_breath_frontend/config/local.storage.config.dart';
import 'package:fatal_breath_frontend/enums/local.types.dart';
import 'package:fatal_breath_frontend/services/firebase.firestore.service.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';

class SendMesssageBar extends StatefulWidget {
  const SendMesssageBar({super.key, required this.receiverId});
  final int receiverId;

  @override
  State<SendMesssageBar> createState() => _SendMesssageBarState();
}

class _SendMesssageBarState extends State<SendMesssageBar> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void submitMessage(String message) async {
    if (message.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();

    final currentUserId = await getLocal(type: LocalTypes.Int, key: "user_id");

    await FirebaseFirestoreService.addTextMessage(
      senderId: currentUserId,
      receiverId: widget.receiverId,
      content: message.trim(),
    );

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalColors.mainColor,
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Message',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.send,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              submitMessage(_messageController.text);
            },
          ),
        ],
      ),
    );
  }
}
