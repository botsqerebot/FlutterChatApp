import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';

var currentScreen = '';
class MyAppBar extends StatefulWidget implements PreferredSizeWidget{
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        title: Text(
          currentScreen,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
  }
}