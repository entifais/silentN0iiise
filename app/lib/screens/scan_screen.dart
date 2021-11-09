import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class ScreenArguments {
  final String title;
  final String description;
  final String url;

  ScreenArguments(this.title, this.description, this.url);
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/ScanScreen');
        },
        label: const Text(
          'Scan QR Code',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        icon: const Icon(
          Icons.qr_code_rounded,
          color: Colors.black,
          size: 40,
        ),
        backgroundColor: Colors.greenAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.greenAccent,
        title: const Text(
          'silentN0iiise',
          style:
              TextStyle(color: Color(0xFF3E3E3E), fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black12,
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Image.asset('assets/logo.png'),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'SilentNOiiise es un proyecto enfocado a la creación  de soluciones a la  necesidad de distribución sonará, esto priorizando la disminución de la contaminación  acústica ',
                style: TextStyle(color: Colors.greenAccent, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();

    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.popAndPushNamed(context, '/HomeScreen');
        },
        label: const Text('Close'),
        icon: const Icon(Icons.close),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.greenAccent,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      Map<String, dynamic> object = jsonDecode(result!.code.toString());

      if (result!.code!.isNotEmpty) {
        Navigator.pushReplacementNamed(
          context,
          '/AudioScreen',
          arguments: ScreenArguments(object['title'].toString(),
              object['description'].toString(), object['url'].toString()),
        );
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
