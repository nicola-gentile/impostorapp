import 'package:flutter/material.dart';
import 'package:impostorapp/utils/colors.dart';
import 'package:impostorapp/utils/sizes.dart';

class QrButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const QrButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.9,
      child: ElevatedButton.icon(
        icon: Icon(
          Icons.qr_code_rounded, 
          size: buttonIconSize,
          color: primaryColor,
        ),
        label: Text(label),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          textStyle: const TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
          side: BorderSide(color: primaryColor, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
        ),
      ),
    );
  }
}