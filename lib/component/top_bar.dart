import 'package:flutter/material.dart';
import 'package:impostorapp/utils/colors.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {

  final String userName;
  final VoidCallback? onBackPressed;
  TopBar({super.key, required this.userName, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () {
          if (onBackPressed != null) {
            onBackPressed!();
          }
          Navigator.pop(context);
        },
      ),
      title: Text(
        userName,
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