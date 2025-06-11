import 'package:flutter/material.dart';
import 'package:impostorapp/component/orange_button.dart';
import 'package:impostorapp/component/qr_button.dart';
import 'package:impostorapp/component/text_input.dart';
import 'package:impostorapp/component/top_bar.dart';
import 'package:impostorapp/utils/sizes.dart';


class JoinRoomScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final userName = args['userName'] ?? '';
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
            const SizedBox(height: 80),
            TextInput(hintText: 'Room code',),
            // const TextField(
            //   decoration: InputDecoration(
            //     hintText: 'Player Name',
            //     filled: true,
            //     fillColor: Color(0xFFF5F5F5),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(12)),
            //       borderSide: BorderSide.none,
            //     ),
            //     contentPadding:
            //         EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            //   ),
            // ),
            const Spacer(),
            OrangeButton(
              label: ' Join Room',
              onPressed: () {},
              icon: Icons.join_full
            ),
            const SizedBox(height: componentsInterspace),
            QrButton(
              label: 'Scan QR Code',
              onPressed: () {},
            ),
            const SizedBox(height: componentsInterspace),
          ],
        ),
      ),
    );
  }
}
