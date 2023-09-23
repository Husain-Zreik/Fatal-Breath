import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (ctx, chatSnapchots) {
          if (chatSnapchots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!chatSnapchots.hasData ||
              chatSnapchots.data!.docChanges.isEmpty) {
            return const Center(
              child: Text("No Messages"),
            );
          }

          final loadedMessages = chatSnapchots.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 100, left: 13, right: 13),
            reverse: true,
            itemCount: loadedMessages.length,
            itemBuilder: (ctx, index) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Align(
                alignment:
                    loadedMessages[index].data()["userId"] != currentUser!.uid
                        ? Alignment.topLeft
                        : Alignment.topRight,
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 130),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: loadedMessages[index].data()["userId"] !=
                            currentUser.uid
                        ? const Color.fromARGB(255, 246, 246, 246)
                        : const Color.fromARGB(255, 187, 50, 51),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    loadedMessages[index].data()["text"],
                    style: loadedMessages[index].data()["userId"] ==
                            currentUser.uid
                        ? const TextStyle(fontSize: 18, color: Colors.white)
                        : const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
