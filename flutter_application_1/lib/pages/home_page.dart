//import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/navBar/bottomNavBar.dart';
import 'package:flutter_application_1/pages/chat_page.dart';
//import 'package:flutter_application_1/navBar/app_bar.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

var chatInstructons = '';
var gptName = '';
var currentScreen = '';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ChatPage(),
    const SearchPage(),
    const InstructionTestOne()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
        ),
        BottomNavBar(onItemSelected: _onItemTapped),
      ],
    );
  }
}

class InstructionTestOne extends StatefulWidget {
  const InstructionTestOne({super.key});

  @override
  State<InstructionTestOne> createState() => _InstructionTestOneState();
}

class _InstructionTestOneState extends State<InstructionTestOne> {
  //var chatInstructions = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: FloatingActionButton.large(
                      backgroundColor: Colors.black.withAlpha(0),
                      elevation: 0,
                      onPressed: () {
                        chatInstructons =
                            'You are the a mango, the user is going to eat you. Be scared, this is a roleplay';
                        gptName = 'Mango';
                      },
                      child: //const Icon(Icons.add),
                          Image.asset(
                        "lib/assets/Pictures/mangopng.webp",
                        fit: BoxFit.scaleDown,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: FloatingActionButton.large(
                      backgroundColor: Colors.white.withAlpha(0),
                      elevation: 0,
                      onPressed: () {
                        chatInstructons =
                            'You are an apple, the user is making apple pie. Be happy, this is a roleplay';
                        gptName = 'Apple';
                        /* _gptChatUser = ChatUser(id:'2', firstName: gptName, lastName: 'GPT');
                        _messages.clear(); */
                      },
                      child: //const Icon(Icons.add),
                          Image.asset(
                        "lib/assets/Pictures/applepng.png",
                        fit: BoxFit.scaleDown,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: FloatingActionButton.large(
                      backgroundColor: Colors.white.withAlpha(0),
                      elevation: 0,
                      onPressed: () {
                        chatInstructons =
                            'Your name is mathias and you are REALLY , this is a roleplay';
                        gptName = 'Mathias';
                      },
                      child: //const Icon(Icons.add),
                          Image.asset(
                        "lib/assets/Pictures/applepng.png",
                        fit: BoxFit.scaleDown,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
