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
              : 'http://192.168.1.5:8000/storage/profile_images/${widget.user.id}.png',
        ),
      ),
      backgroundColor: GlobalColors.bgColor,
      body: const SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
      bottomNavigationBar: Container(
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
                  // autofocus: true,
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
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
