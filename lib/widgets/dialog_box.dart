import 'package:flutter/material.dart';
import 'package:qr_code_scanner/constants/constants.dart';

Future<void> displayAlertDialog(
    BuildContext context, String scannedText) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text("Scan Erfolgreich!"),
          content: SingleChildScrollView(
            child: ListBody(children: [
              const Text("Der gescannte QR-Code enthält folgenden Text:"),
              const SizedBox(height: 10),
              Text(scannedText),
            ]),
          ),
        );
      });
}
