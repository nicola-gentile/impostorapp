import 'package:flutter/material.dart';
import 'package:impostorapp/component/orange_button.dart';
import 'package:impostorapp/component/players_list.dart';
import 'package:impostorapp/component/qr_button.dart';
import 'package:impostorapp/component/top_bar.dart';
import 'package:impostorapp/utils/sizes.dart';


class CreateRoomScreen extends StatelessWidget {

  final String username;
  const CreateRoomScreen({
    super.key,
    required this.username
  });

  @override
  Widget build(BuildContext context) {
    var players = ["ile", "rob", "dav", "nic", "bis", "fra", "ale", "rug", "mar", "pol", "ser", "don"];
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: TopBar(),
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
              'ABCD1234',
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
              onPressed: () {},
              icon: Icons.gamepad
            ),
            const SizedBox(height: componentsInterspace),
            QrButton(
              label: 'show QR code',
              onPressed: () {},
            ),
            const SizedBox(height: componentsInterspace),
          ],
        ),
      ),
    );
  }
}
