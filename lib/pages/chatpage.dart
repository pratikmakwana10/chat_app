import 'package:chat_app/components/Chat_bubble.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/services/authentication/auth_services.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String recieverEmail;
  final String recieverID;

  const ChatPage(
      {super.key, required this.recieverEmail, required this.recieverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
// text controller
  final TextEditingController _textController = TextEditingController();

  // chat service
  final ChatService chatService = ChatService();

  final AuthService authService = AuthService();

  FocusNode focusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
        );
        print('has focus');
      } else {
        print('lost focus');
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  //send message
  void sendMessage() async {
    // if there is no text
    if (_textController.text.isNotEmpty) {
      // send message
      await chatService.sendMessage(
        widget.recieverID,
        _textController.text,
      );
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recieverEmail),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildChatList(),
          ),
          //user input field
          _buildInputField(),
        ],
      ),
    );
  }

  // build chat list
  Widget _buildChatList() {
    String senderId = authService.getCurrentuser()?.uid ?? '';
    return StreamBuilder(
      stream: chatService.getMessages(widget.recieverID, senderId),
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
          final chats = snapshot.data;
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        }
        return const Center(
          child: Text('No chats found'),
        );
      },
    );
  }

// build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == authService.getCurrentuser()?.uid;
    print("»»»»»»»»»»»»»»»»»»$isCurrentUser");

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      // alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data['message'], isSender: isCurrentUser,

            // subtitle: Text(message['senderEmail']),
          ),
        ],
      ),
    );
  }

// build message input
  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _textController,
              obscureText: false,
              hintText: 'Type a message',
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              color: Color.fromARGB(255, 24, 89, 142),
              size: 35,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
