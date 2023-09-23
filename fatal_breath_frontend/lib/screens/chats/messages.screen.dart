import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:fatal_breath_frontend/providers/firebase.provider.dart';
import 'package:fatal_breath_frontend/widgets/chat.messages.dart';
import 'package:fatal_breath_frontend/widgets/send.message.bar.dart';
import 'package:flutter/material.dart';
import 'package:fatal_breath_frontend/models/user.model.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/widgets/secondary.appbar.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen(
      {super.key, required this.user, required this.currentUser});

  final User user;
  final User currentUser;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
        .getMessages(widget.user.id, widget.currentUser.id);
    super.initState();
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/main-bg3.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            ChatMessages(receiverId: widget.user.id),
            SendMesssageBar(receiverId: widget.user.id),
          ],
        ),
      ),
    );
  }
}
