import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mia_pos_v1/screens/main_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          onPrimary: Color.fromRGBO(245, 248, 252, 1),
          primaryContainer: Color.fromRGBO(47, 128, 237, 1),
          outline: Color.fromRGBO(232, 230, 240, 1),
          surface: Color.fromRGBO(244, 245, 247, 1),
          onInverseSurface: Color.fromRGBO(204, 211, 221, 1),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.onestTextTheme()
      ),
      home: const MainScreen(),
    );
  }
}
