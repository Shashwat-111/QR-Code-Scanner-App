import 'package:flutter/material.dart';

class InstructionText extends StatelessWidget {
  const InstructionText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Scannen Sie den QR-Code", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
        SizedBox(height: 10),
        Text(
          "Scannen Sie den QR-Code auf der Unterseite des Gateways, um die Installation fortzusetzen",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
