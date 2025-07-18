import 'package:flutter/material.dart';
import 'package:impostorapp/component/error_popup.dart';
import 'package:impostorapp/component/top_bar.dart';
import 'package:impostorapp/network/sse_service.dart';

class WordScreen extends StatefulWidget {

  const WordScreen({super.key});

  @override
  State<WordScreen> createState() => _WordScreenState();

}

class _WordScreenState extends State<WordScreen> {

  String word = '';
  SseService sseService = SseService();

  void setWaitingState() {
    setState(() {
      word = 'Waiting for the word...';
    });
  }

  void setWord(String newWord) {
    setState(() {
      word = newWord;
    });
  }

  @override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if(!mounted) return;
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final userId = args['userId'] ?? '';

    setWaitingState();

    sseService.connectSsePlayer(
      userId, 
      onData: (_) {},
      onDone: () { 
        if (context.mounted) {
          Navigator.pop(context);
        }
      })
      .listen((res) {
        final data = res.data;
        if (data != null) {
          switch (data['type']) {
            case 'start':
              setWord(data['word']);
              break;
            case 'end':
              setWaitingState();
              break;
            case 'close':
              sseService.disconnect();
              if(context.mounted) {
                Navigator.pop(context);
                showErrorPopup(context, 'room was closed');
              }
          }
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final userName = args['userName'] ?? '';
    return Scaffold(
      appBar: TopBar(
        userName: userName,
        onBackPressed: () => sseService.disconnect(),
      ),
      body: Center(
        child: Text(word, style: TextStyle(fontSize: 30),),
      )
    );
  }

}