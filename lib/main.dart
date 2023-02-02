import 'package:flutter/material.dart';
import 'package:flutter_currency_exchange_app/screens/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme:
            const AppBarTheme(elevation: 0, backgroundColor: Colors.white70),
      ),
      home: const HomePage(),
    );
  }
}
