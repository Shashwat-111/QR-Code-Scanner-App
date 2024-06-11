import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(241, 239, 229,1),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 47),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              const SizedBox(height:85),
              SizedBox(
                width: 140,
                height: 66,
                child: Image.asset("assets/Logo.png"),
              ),
              const Spacer(),
              Container(
                //decoration: BoxDecoration(borderRadius: ),
                height: 295,width: 295,
                color: Colors.black,
                child: MobileScanner(
                  onDetect: (capture){
                    if (kDebugMode) {
                      print(capture.raw);
                    }
                  },
                ),
              ),
              //const QRScannerOverlay(overlayColour: Colors.white),
              const Spacer(),
              const Text(
                "Scannen Sie den QR-Code",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),),
              const SizedBox(height: 10),
              const Text(
                "Scannen Sie den QR-Code auf der Unterseite des Gateways, um die Installation fortzusetzen",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500 , fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height:85),
            ],
          ),
        ),
      ),
    );
  }
}
