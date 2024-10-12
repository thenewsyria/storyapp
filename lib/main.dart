import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'story_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Socially App',
      theme: ThemeData(
        primaryColor: const Color(0xFF1D2732),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
          bodyLarge: TextStyle(color: Colors.black38, fontSize: 14),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1D2732),
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const HomeScreen(),
      routes: {
        '/story': (context) => const StoryScreen(),
      },
    );
  }
}