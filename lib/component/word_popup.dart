import 'package:flutter/material.dart';

void showWordPopup(BuildContext context, String word) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          width: double.maxFinite,
          alignment: Alignment.center,
          child: Text(
            word,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }