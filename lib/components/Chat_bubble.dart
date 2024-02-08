import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  const ChatBubble({super.key, required this.message, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSender ? Colors.blue : Colors.grey[400],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isSender ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}