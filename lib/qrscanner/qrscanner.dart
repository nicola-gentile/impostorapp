import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

Future<String?> scanQRCode(BuildContext context) async {
  final result = await Navigator.push<String>(
    context,
    MaterialPageRoute(
      builder: (context) => _QRScannerScreen(),
    ),
  );
  return result;
}

class _QRScannerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan QR Code')),
      body: MobileScanner(
        onDetect: (result) {
          final String? code = result.barcodes.first.rawValue;
          if (code != null) {
            Navigator.pop(context, code); // Return the scanned result
          }
        },
      ),
    );
  }
}
