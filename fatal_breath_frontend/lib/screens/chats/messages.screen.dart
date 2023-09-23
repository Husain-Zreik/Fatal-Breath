import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:fatal_breath_frontend/models/message.model.dart';
import 'package:fatal_breath_frontend/providers/user.provider.dart';
import 'package:fatal_breath_frontend/widgets/send.message.bar.dart';
import 'package:flutter/material.dart';
import 'package:fatal_breath_frontend/models/user.model.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/widgets/secondary.appbar.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key, required this.user});

  final User user;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  _chatBubble(Message message, bool isMe) {
    if (!isMe) {
      return Container(
        alignment: Alignment.topLeft,
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.70),
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
              child: Text(message.content)),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.topRight,
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.70),
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
              child: Text(message.content)),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // ignore: unused_local_variable
    final currentUser =
        Provider.of<UserProvider>(context, listen: false).getCurrentUser;
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
      body: const Column(
        children: [
          // Expanded(
          //   // child: ListView.builder(
          //   //   reverse: true,
          //   //   padding: const EdgeInsets.all(20),
          //   //   itemCount: messages.length,
          //   //   itemBuilder: (BuildContext context, int index) {
          //   //     final Message message = messages[index];
          //   //     final bool isMe = message.sender!.id == currentUser.id;
          //   //     // final bool isSameUser = prevUserId == message.sender.id;
          //   //     // prevUserId = message.sender.id;
          //   //     return _chatBubble(message, isMe);
          //   //   },
          //   // ),
          // ),
          SendMesssageBar(),
        ],
      ),
    );
  }
}
