import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:impostorapp/component/error_popup.dart';
import 'package:impostorapp/component/orange_button.dart';
import 'package:impostorapp/component/text_input.dart';
import 'package:impostorapp/utils/colors.dart';
import 'package:impostorapp/utils/sizes.dart';
import 'package:impostorapp/network/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void createRoom(String userName, BuildContext context) {
    if (userName.isEmpty) {
      showErrorPopup(context, 'type a name');
    } else {
      SharedPreferences.getInstance()
        .then((pref) {
          pref.setString('name', userName);
        });
      final apiService = ApiService();
      apiService.createRoom(userName).then((response) {
        if (response.statusCode == 200) {
          final body = jsonDecode(response.body); // Assuming the response body contains the room code
          final roomCode = body['room_code'] as String? ?? '';
          final ownerId = body['owner_id'] as int? ?? 0; // Assuming the response body contains the owner ID
          final roomId = body['room_id'] as int? ?? 0; // Assuming the response body contains the room ID
          Navigator.pushNamed(
            context,
            '/create',
            arguments: {'userName': userName, 'roomCode': roomCode, 'ownerId': ownerId, 'roomId': roomId},
          );
        } else {
          final body = jsonDecode(response.body);
          final details = body['detail'] as String? ?? 'Unknown error';
          showErrorPopup(context, 'Failed to create room: $details');
        }
      }).catchError((error) {
        showErrorPopup(context, 'Error creating room: check for internet connection and retry');
      });
    }
  }

  void joinRoom(String userName, BuildContext context) {
    if (userName.isEmpty) {
      showErrorPopup(context, 'type a name');
    } else {
      SharedPreferences.getInstance()
        .then((pref) {
          pref.setString('name', userName);
        });
      Navigator.pushNamed(
        context,
        '/join',
        arguments: {'userName' : userName }, // Replace with actual player name
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var textInput = TextInput(hintText: 'Player name', );
    SharedPreferences.getInstance()
      .then((pref) {
        final lastName = pref.getString('name');
        if(lastName != null) {
          textInput.text = lastName;
        }
      });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              Row(
                children: const [
                  Icon(Icons.videogame_asset, color: primaryColor, size:37),
                  SizedBox(width: 12),
                  Text(
                    'Impostor',
                    style: TextStyle(
                      fontSize: topBarFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              textInput,
              const Spacer(),
              OrangeButton(
                icon: Icons.group,
                label: ' Join Room',
                onPressed: () => joinRoom(textInput.text, context)
              ),
              const SizedBox(height: componentsInterspace),
              OrangeButton(
                icon: Icons.add,
                label: 'Create Room',
                onPressed: () => createRoom(textInput.text, context),
              ),
              const SizedBox(height: componentsInterspace),
            ],
          ),
        ),
      ),
    );
  }
}

