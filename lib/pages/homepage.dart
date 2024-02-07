import 'package:chat_app/components/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
      ),
      drawer: const MyDrawer(),
      body: const Center(
        child: Text('Welcome to the chat app'),
      ),
    );
  }
}
