import 'package:flutter/material.dart';
import 'package:impostorapp/utils/colors.dart';

void showErrorPopup(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Error'),
      content: Text(errorMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'OK', 
            style: TextStyle(color: primaryColor),
          )
        ),
      ],
    ),
  );
}