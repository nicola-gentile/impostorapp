import 'package:flutter/material.dart';
import 'package:impostorapp/screen/home.dart';
import 'package:impostorapp/screen/join_room.dart';
import 'package:impostorapp/screen/create_room.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Screen App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/join': (context) => const JoinRoomScreen(username: ''),
        '/create': (context) => const CreateRoomScreen(username: ''),
        // '/waiting': (context) => const WaitingRoomScreen(),
      },
    );
  }
}