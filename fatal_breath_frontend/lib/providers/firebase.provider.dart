import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fatal_breath_frontend/models/message.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseProvider extends ChangeNotifier {
  ScrollController scrollController = ScrollController();

  List<Message> messages = [];

  List<Message> getMessages(String receiverId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
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
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
}
