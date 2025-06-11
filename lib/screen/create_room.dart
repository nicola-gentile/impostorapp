import 'package:flutter/material.dart';
import 'package:impostorapp/component/orange_button.dart';
import 'package:impostorapp/component/players_list.dart';
import 'package:impostorapp/component/qr_button.dart';
import 'package:impostorapp/component/qr_popup.dart';
import 'package:impostorapp/component/top_bar.dart';
import 'package:impostorapp/component/word_popup.dart';
import 'package:impostorapp/network/sse_service.dart';
import 'package:impostorapp/screen/word.dart';
import 'package:impostorapp/utils/sizes.dart';
import 'package:impostorapp/network/api_service.dart';
import 'package:impostorapp/component/error_popup.dart';
import 'dart:convert';

class CreateRoomScreen extends StatefulWidget {

  final String userName;
  final int ownerId;
  final String roomCode;

  const CreateRoomScreen({
    super.key,
    required this.userName,
    required this.ownerId,
    required this.roomCode,
  });

  @override
  State<CreateRoomScreen> createState() => CreateRoomScreenState();

}

class CreateRoomScreenState extends State<CreateRoomScreen> {

  final ApiService _apiService = ApiService();
  final SseService _sseService = SseService();

  @override
  void initState() {
    super.initState();
    _sseService.connectSseOwner(
      widget.ownerId,
      onData: (res) {},
      onError: (err) { _sseService.disconnect(); }
      ).listen((res) {
        final data = res.data;
        if (data == null) {
          return;
        }
        switch (data['type']) {
          case 'joined': 
            addPlayer(data['user_name']);
            break;
          case 'left':
            removePlayer(data['user_name']);
            break;
          case 'start':
            if(context.mounted) {
              Navigator.pushNamed(
                context,
                '/word-owner',
                arguments: { 'ownerId' : widget.ownerId, 'userName': widget.userName, 'word': data['word'] },
              );
            }
            break;
          default:
        }
      },
      onError: (_) { },
      onDone: () { }
      );

  }

  List<String> players = [];

  void addPlayer(String playerName) {
    setState(() {
      players.add(playerName);
    });
  }

  void removePlayer(String playerName) {
    setState(() {
      players.remove(playerName);
    });
  }

  @override
  void dispose() async {
    _apiService.close(widget.ownerId);
    _sseService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userName = widget.userName;
    var roomCode = widget.roomCode;
    var ownerId = widget.ownerId;
    
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: false,
      appBar: TopBar(userName: userName),
      body: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              roomCode,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 36),
            ),
            Text(
              'room code',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: componentsInterspace),
            Expanded(
              child: PlayersList(names: players),
            ),
            SizedBox(height: componentsInterspace),
            OrangeButton(
              label: ' Start game',
              onPressed: () {
                _apiService
                  .start(ownerId)
                  .then((response) {
                    if (response.statusCode != 200) {
                      var body = jsonDecode(response.body);
                      var details = body['detail'] as String? ?? 'Unknown error';
                      showErrorPopup(context, details);
                    } 
                  });
              },
              icon: Icons.gamepad
            ),
            const SizedBox(height: componentsInterspace),
            QrButton(
              label: 'show QR code',
              onPressed: () { 
                showQRPopup(context, roomCode); 
              },
            ),
            const SizedBox(height: componentsInterspace),
          ],
        ),
      ),
    );
  }
}
