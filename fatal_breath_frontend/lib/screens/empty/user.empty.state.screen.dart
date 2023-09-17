import 'package:fatal_breath_frontend/utils/text.note.dart';
import 'package:flutter/material.dart';

class UserEmptyStateScreen extends StatelessWidget {
  const UserEmptyStateScreen({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextNote(text: text),
          ],
        ),
      ),
    );
  }
}
