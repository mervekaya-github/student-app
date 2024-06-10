import 'package:flutter/material.dart';
import '../services/chat_service.dart';
import '../models/chat.dart';
import '../widgets/chat_list_tile.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  final ChatService chatService;

  const ChatListScreen({super.key, required this.chatService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesajlarım'),
        backgroundColor: Colors.lightBlue[800],
      ),
      body: StreamBuilder<List<Chat>>(
        stream: chatService.getChats(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final chats = snapshot.data!;
          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              return ChatListTile(
                chat: chats[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen(chat: chats[index], chatService: chatService)),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
