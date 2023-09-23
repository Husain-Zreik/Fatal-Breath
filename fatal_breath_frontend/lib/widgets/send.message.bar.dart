import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class SendMesssageBar extends StatefulWidget {
  const SendMesssageBar({super.key});

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

  void submitMessage(String message) {
    if (message.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();

    // final user = FirebaseAuth.instance.currentUser!;

    // FirebaseFirestore.instance.collection("chat").add({
    //   "text": enteredText,
    //   "createdAt": Timestamp.now(),
    //   "userId": user.uid,
    // });

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
