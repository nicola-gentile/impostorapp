import 'package:flutter/material.dart';
import 'package:impostorapp/component/top_bar.dart';
import 'package:impostorapp/network/api_service.dart';

class WordOwnerScreen extends StatelessWidget {


  const WordOwnerScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final userName = args['userName'] ?? '';
    final word = args['word'] ?? '';
    return Scaffold(
      appBar: TopBar(
        userName: userName,
        onBackPressed: () {
          final api = ApiService();
          final data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
          api.end(data['ownerId']);
        },
        ),
      body: Center(
        child: Text(word, style: TextStyle(fontSize: 30),),
      )
    );
  }

}