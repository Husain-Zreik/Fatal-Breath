import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fatal_breath_frontend/models/message.model.dart';
import 'package:flutter/material.dart';

class FirebaseProvider extends ChangeNotifier {
  ScrollController scrollController = ScrollController();

  List<Message> messages = [];

  List<Message> getMessages(int receiverId, int senderId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(senderId.toString())
        .collection('chat')
        .doc(receiverId.toString())
        .collection('messages')
        .orderBy('sentTime', descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((messages) {
      this.messages =
          messages.docs.map((doc) => Message.fromJson(doc.data())).toList();
      notifyListeners();

      scrollDown();
    });
    return messages;
  }

  void scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
}
