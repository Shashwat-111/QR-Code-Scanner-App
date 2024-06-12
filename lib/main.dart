import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home()
    );
  }
}


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String scannedText = "N/A";
  bool isScanCompleted = false;
  void startReScan() {
    setState(() {
      isScanCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 239, 229, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 85),
            SizedBox(
              width: 140,
              height: 66,
              child: Image.asset("assets/Logo.png"),
            ),
            const Spacer(),
            SizedBox(
              height: 290,
              width: 290,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: SizedBox(
                      height: 280,
                      width: 280,
                      child: MobileScanner(
                          fit: BoxFit
                              .cover, // Ensure the scanner fits its container
                          onDetect: (capture) {
                            if(isScanCompleted == false && capture.barcodes.first.rawValue != null)
                              {
                                isScanCompleted= true;
                                scannedText = capture.barcodes.first.rawValue!;
                                _AlertDialog(context, scannedText).then((value) => startReScan());
                              }

                          }),
                    ),
                  ),
                  QRScannerOverlay(
                    overlayColor: Colors.transparent,
                    scanAreaHeight: 290,
                    scanAreaWidth: 290,
                    borderColor: Colors.black,
                    borderRadius: 25,
                    borderStrokeWidth: 5,
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              "Scannen Sie den QR-Code",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            const Text(
              "Scannen Sie den QR-Code auf der Unterseite des Gateways, um die Installation fortzusetzen",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 85),
          ],
        ),
      ),
    );
  }
}

Future<void> _AlertDialog(BuildContext context, String scannedText) async {
  return showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(241, 239, 229, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text("Scan Erfolgreich!"),
      content: SingleChildScrollView(
        child: ListBody(
            children: [
              const Text("Der gescannte QR-Code enthält folgenden Text:"),
              SizedBox(height: 10),
              Text(scannedText),
            ]
        ),
      ),
    );
  });
}