// import 'package:flutter_application_1/main.dart';
// import 'package:flutter_application_1/navBar/bottomNavBar.dart';
import 'package:flutter_application_1/const.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/navBar/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(
        seconds: 20,
      ),
    ),
    enableLog: true,
  );

  final ChatUser _currentUser =
      ChatUser(id: '1', firstName: 'Seb', lastName: 'HG');

  final ChatUser _gptChatUser =
      ChatUser(id: '2', firstName: gptName, lastName: 'GPT');

  final List<ChatMessage> _messages = <ChatMessage>[];
  final List<ChatUser> _typingUsers = <ChatUser>[];

  //var chatInstructions = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 64),
        child: DashChat(
            currentUser: _currentUser,
            typingUsers: _typingUsers,
            messageOptions: const MessageOptions(
              currentUserContainerColor: Colors.black,
              containerColor: Colors.blue,
              textColor: Colors.white,
            ),
            onSend: (ChatMessage m) {
              getChatResponse(m);
            },
            messages: _messages),
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_gptChatUser);
    });

    List<Messages> messagesHistory = [
      Messages(
          role: Role.system,
          content:
              "$chatInstructons. You are not permittet to use any special characters. You only have 300 tokens to write with also. You are not a chatbot so act like a human or food with feelings") // Add system message here
    ];

    messagesHistory.addAll(_messages.reversed.map((m) {
      if (m.user == _currentUser) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList());

    final request = ChatCompleteText(
      model: Gpt4oMiniChatModel(),
      //model: Gpt4ChatModel(),
      messages: messagesHistory.map((message) => message.toJson()).toList(),
      maxToken: 300,
    );
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
            0,
            ChatMessage(
                user: _gptChatUser,
                createdAt: DateTime.now(),
                text: element.message!.content),
          );
        });
      }
    }
    setState(() {
      _typingUsers.remove(_gptChatUser);
    });
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text('This is the Search Page'),
      ),
    );
  }
}
