import 'package:flutter/material.dart';
import 'package:impostorapp/component/error_popup.dart';
import 'package:impostorapp/component/orange_button.dart';
import 'package:impostorapp/component/text_input.dart';
import 'package:impostorapp/utils/colors.dart';
import 'package:impostorapp/utils/sizes.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void create_room(String username, BuildContext context) {
    if (username.isEmpty) {
      showErrorPopup(context, 'type a name');
    } else {
      Navigator.pushNamed(
        context,
        '/create',
        arguments: {'username' : username }, // Replace with actual player name
      );
    }
  }

  void join_room(String username, BuildContext context) {
    if (username.isEmpty) {
      showErrorPopup(context, 'type a name');
    } else {
      Navigator.pushNamed(
        context,
        '/join',
        arguments: {'username' : username }, // Replace with actual player name
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var textInput = TextInput(hintText: 'Player name',);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                onPressed: () => join_room(textInput.text, context)
              ),
              const SizedBox(height: componentsInterspace),
              OrangeButton(
                icon: Icons.add,
                label: 'Create Room',
                onPressed: () => create_room(textInput.text, context),
              ),
              const SizedBox(height: componentsInterspace),
            ],
          ),
        ),
      ),
    );
  }
}

