import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:fatal_breath_frontend/widgets/chat.messages.dart';
import 'package:fatal_breath_frontend/widgets/send.message.bar.dart';
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
          ChatMessages(receiverId: widget.user.id),
          SendMesssageBar(receiverId: widget.user.id),
        ],
      ),
    );
  }
}
