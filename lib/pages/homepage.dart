import 'package:chat_app/components/drawer.dart';
import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/pages/chatpage.dart';
import 'package:chat_app/services/authentication/auth_services.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
// chat & auth service
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        backgroundColor: Colors.transparent,
        elevation: 2,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: chatService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          final users = snapshot.data;

          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
          // return ListView.builder(
          //   itemCount: users?.length,
          //   itemBuilder: (context, index) {
          //     final user = users?[index];
          //     return ListTile(
          //       title: Text(user?['name']),
          //       subtitle: Text(user?['email']),
          //     );
          //   },
          // );
        }
        return const Center(
          child: Text('No users found'),
        );
      },
    );
  }

  //build individiual user list item

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all users expect the current user

    if (userData['email'] != authService.getCurrentuser()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          //»»»» tapped user go to chat page with the user
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        recieverEmail: userData['email'],
                        recieverID: userData['uid'],
                      )));
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
