import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void showQRPopup(BuildContext context, String data) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Center(child: Text('QR Code')),
      content:  SizedBox(
        width: 200,
        height: 200,
        child: Center(
          child: QrImageView(
            data: data,
            version: QrVersions.auto,
            size: 200,
          )
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}