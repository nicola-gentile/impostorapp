import 'package:flutter/material.dart';
import 'package:impostorapp/utils/colors.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    final ctx = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return AppBar(
      backgroundColor: primaryColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        ctx['username'],
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}