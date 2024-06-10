import 'package:flutter/material.dart';
import '../models/chat.dart';

class ChatListTile extends StatelessWidget {
  final Chat chat;
  final VoidCallback onTap;

  const ChatListTile({super.key, required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(chat.profilePic),
      ),
      title: Text(chat.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(chat.message),
      trailing: Text(chat.time),
      onTap: onTap,
    );
  }
}
