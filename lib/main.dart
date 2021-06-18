import 'package:flutter/material.dart';
import 'pages/price_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Future main() async {runApp(MyApp())};

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white),
      home: PriceScreen(),
    );
  }
}
