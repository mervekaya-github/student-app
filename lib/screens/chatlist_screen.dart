import 'package:flutter/material.dart';
import 'package:student_app/models/chat.dart';
import 'package:student_app/screens/chat_screen.dart';
import 'package:student_app/services/chat_service.dart';
import 'package:student_app/widgets/chat_list_tile.dart';

class ChatListScreen extends StatelessWidget {
  final ChatService chatService;

  ChatListScreen({super.key, required this.chatService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        title: const Text('Mesajlarım'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Chat>>(
        stream: chatService.getChats(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final chats = snapshot.data!;

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];

              return ChatListTile(
                chat: chat,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        chat: chat,
                        chatService: chatService,
                      ),
                    ),
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
