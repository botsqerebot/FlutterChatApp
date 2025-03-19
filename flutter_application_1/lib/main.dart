//import 'package:flutter_application_1/models/nav_item_model.dart';
//import 'package:flutter_application_1/pages/chat_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        fontFamily: GoogleFonts.ubuntu().fontFamily,
      ),
      home: HomePage(),
    );
  }
}