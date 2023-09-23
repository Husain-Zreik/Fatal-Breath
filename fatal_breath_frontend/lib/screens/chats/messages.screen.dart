import 'package:fatal_breath_frontend/config/local.storage.config.dart';
import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:fatal_breath_frontend/enums/local.types.dart';
import 'package:fatal_breath_frontend/models/message.model.dart';
import 'package:flutter/material.dart';
import 'package:fatal_breath_frontend/models/user.model.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/widgets/secondary.appbar.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key, required this.user});

  final User user;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _messageController = TextEditingController();

  final int? currentUserId = 1;
  // final int? currentUserId = getLocal(type: LocalTypes.Int, key: "user_id");

  _chatBubble(Message message, bool isMe) {
    if (isMe) {
      return Container(
        alignment: Alignment.topLeft,
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.80),
          child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Text(message.text!)),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.topRight,
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.80),
          child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.zero,
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Text(message.text!)),
        ),
      );
    }
  }

  _sendMessageArea() {
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
              // String message = _messageController.text;
              _messageController.clear();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SecondaryAppBar(
          title: widget.user.name,
          isProfile: true,
          imageLink: widget.user.profileImage == null
              ? null
              : '$baseUrl/storage/profile_images/${widget.user.id}.png',
        ),
      ),
      backgroundColor: GlobalColors.bgColor,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(20),
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final Message message = messages[index];
                final bool isMe = message.sender!.id == currentUserId;
                // final bool isSameUser = prevUserId == message.sender.id;
                // prevUserId = message.sender.id;
                return _chatBubble(message, isMe);
              },
            ),
          ),
          _sendMessageArea(),
        ],
      ),
      // bottomNavigationBar: Container(
      //   color: GlobalColors.mainColor,
      //   padding: const EdgeInsets.only(top: 15, bottom: 15, left: 20),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: Container(
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(40),
      //           ),
      //           child: TextField(
      //             // autofocus: true,
      //             controller: _messageController,
      //             decoration: const InputDecoration(
      //               hintText: 'Message',
      //               border: InputBorder.none,
      //               contentPadding: EdgeInsets.symmetric(horizontal: 16),
      //             ),
      //           ),
      //         ),
      //       ),
      //       IconButton(
      //         icon: const Icon(
      //           Icons.send,
      //           color: Colors.white,
      //           size: 30,
      //         ),
      //         onPressed: () {
      //           // String message = _messageController.text;
      //           _messageController.clear();
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      // resizeToAvoidBottomInset: false,
    );
  }
}
