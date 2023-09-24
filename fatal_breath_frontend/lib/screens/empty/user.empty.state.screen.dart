import 'package:fatal_breath_frontend/utils/text.note.dart';
import 'package:flutter/material.dart';

class UserEmptyStateScreen extends StatelessWidget {
  const UserEmptyStateScreen({Key? key, required this.text, this.isSearch})
      : super(key: key);

  final String text;
  final bool? isSearch;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isSearch != null
                  ? "assets/images/search_icon.png"
                  : "assets/images/empty_house_icon.png",
            ),
            TextNote(text: text),
          ],
        ),
      ),
    );
  }
}
