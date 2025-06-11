import 'package:flutter/material.dart';
import 'package:impostorapp/network/api_service.dart';
import 'package:impostorapp/screen/home.dart';
import 'package:impostorapp/screen/join_room.dart';
import 'package:impostorapp/screen/create_room.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:impostorapp/screen/word.dart';
import 'package:impostorapp/screen/word_owner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  try {
    await dotenv.load(fileName: ".env"); // Load environment variables
  } catch (e) {
    throw Exception('Error loading .env file: $e'); // Print error if any
  }
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
        '/join': (context) => JoinRoomScreen(),
        '/word': (context) => WordScreen(),
        '/word-owner': (context) => WordOwnerScreen(),
        '/create': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
          return CreateRoomScreen(
            userName: args['userName'] ?? '',
            ownerId: args['ownerId'] ?? -1,
            roomCode: args['roomCode'] ?? '',
          );

        },
        // '/waiting': (context) => const WaitingRoomScreen(),
      },
    );
  }
}