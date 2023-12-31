import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fatal_breath_frontend/models/message.model.dart';

class FirebaseFirestoreService {
  static final firestore = FirebaseFirestore.instance;

  static Future<void> addTextMessage({
    required String content,
    required int receiverId,
    required int senderId,
  }) async {
    final message = Message(
      content: content,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      senderId: senderId,
    );
    await _addMessageToChat(receiverId, senderId, message);
  }

  static Future<void> _addMessageToChat(
    int receiverId,
    int senderId,
    Message message,
  ) async {
    // add the message to the sender
    await firestore
        .collection('users')
        .doc(senderId.toString())
        .collection('chat')
        .doc(receiverId.toString())
        .collection('messages')
        .add(message.toJson());

    // add the message to the reciever
    await firestore
        .collection('users')
        .doc(receiverId.toString())
        .collection('chat')
        .doc(senderId.toString())
        .collection('messages')
        .add(message.toJson());
  }
}
