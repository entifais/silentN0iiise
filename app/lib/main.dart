import 'package:app/screens/scan_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'screens/audio_screen.dart';

void main() => runApp(const MaterialApp(home: MyHome()));

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/HomeScreen': (context) => const ScanScreen(),
        '/ScanScreen': (context) => const QRViewExample(),
        '/AudioScreen': (context) => const AudioScreen()
      },
      title: 'silentN0iiise',
      home: const ScanScreen(),
    );
  }
}
