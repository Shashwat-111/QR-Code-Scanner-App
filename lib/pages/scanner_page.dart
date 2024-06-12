import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import '../constants/constants.dart';
import '../widgets/dialog_box.dart';
import '../widgets/instruction_text_widget.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String scannedText = "N/A";
  bool isScanCompleted = false;

  void restartScan() {
    setState(() {
      isScanCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    //Get the height & width of the screen
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        // A padding of 10% from all sides
        padding: EdgeInsets.symmetric(horizontal: 0.1*width , vertical: 0.1*height),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildLogo(), //gets the "MOE" logo
            const Spacer(),
            buildScanWindow(height, width), //builds the scanner with the required overlay
            const Spacer(),
            const InstructionText(), // Displays the bottom texts
          ],
        ),
      ),
    );
  }

  Widget buildScanWindow(double height, double width){
    return SizedBox(
      //The scan window takes 75% of the screen width
      height: 0.75 * width,
      width: 0.75 * width,

      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: SizedBox(
              height: 0.75 * width-10,
              width: 0.75 * width-10,
              child: MobileScanner(
                //As soon as a valid QR Code is detected,
                // a alert dialog Box is displayed, containing the contents.
                // After the Dialog is dismissed by the user, restartScan() function
                // starts to find a valid QR again.
                  onDetect: (capture) {
                    if (isScanCompleted == false &&
                        capture.barcodes.first.rawValue != null) {
                      isScanCompleted = true;
                      scannedText = capture.barcodes.first.rawValue!;
                      displayAlertDialog(context, scannedText)
                          .then((value) => restartScan());
                    }
                  }),
            ),
          ),

          //This builds the rounded arc around the scanner,
          // to give it the required look.
          QRScannerOverlay(
            overlayColor: Colors.transparent,
            scanAreaHeight: 0.75 * width,
            scanAreaWidth: 0.75 * width,
            borderColor: Colors.black,
            borderRadius: 25,
            borderStrokeWidth: 5,
          ),
        ],
      ),
    );
  }

// Widget to build the logo. The logo is set to a predefined, constant size.
  Widget buildLogo(){
    return SizedBox(
      width: 140,
      height: 66,
      child: Image.asset("assets/Logo.png"),
    );
  }
}

