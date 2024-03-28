import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController chatController = TextEditingController();
  final _messages = [];

  void _sendMessage(String message) {
    setState(() {
      _messages.add(Text(message));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lets Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemBuilder: (context, index) => _messages[index],
              itemCount: _messages.length,

            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Write a message',
                      ),
                        onSubmitted: (message) => _sendMessage(message),
                    )
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
