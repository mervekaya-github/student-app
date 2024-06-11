import 'package:flutter/material.dart';
import '../models/chat.dart';

class ChatListTile extends StatelessWidget {
  final Chat chat;
  final VoidCallback onTap;

  ChatListTile({required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(chat.profilePic),
      ),
      title: Text(chat.name),
      subtitle: Text(chat.message),
      trailing: Text(
        _formatTime(chat.time),
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
      onTap: onTap,
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 1) {
      return '${time.day}/${time.month}/${time.year}';
    } else if (difference.inDays == 1) {
      return 'Dün';
    } else {
      return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    }
  }
}
