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

var kColorScheme = const ColorScheme.light(
  onPrimary: Color.fromRGBO(245, 248, 252, 1),
  primaryContainer: Color.fromRGBO(47, 128, 237, 1),
  outline: Color.fromRGBO(232, 230, 240, 1),
  surface: Color.fromRGBO(244, 245, 247, 1),
  onInverseSurface: Color.fromRGBO(204, 211, 221, 1),
  secondaryContainer: Color.fromRGBO(250, 251, 252, 1),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: kColorScheme,
          indicatorColor: Colors.black87,
          textSelectionTheme:
              TextSelectionThemeData(selectionHandleColor: Colors.black54),
          inputDecorationTheme: InputDecorationTheme().copyWith(
            filled: true,
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(232, 230, 240, 1), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(232, 230, 240, 1), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(232, 230, 240, 1), width: 1),
            ),
            focusColor: Colors.blue,
            fillColor: kColorScheme.secondaryContainer,
            iconColor: Colors.blue,
            hoverColor: Colors.blue,
            labelStyle: TextStyle().copyWith(color: Color.fromRGBO(171, 169, 177, 1)),
            floatingLabelStyle: TextStyle(color: Color.fromRGBO(171, 169, 177, 1))
          ),
          useMaterial3: true,
          textTheme: GoogleFonts.onestTextTheme()),
      home: const MainScreen(),
    );
  }
}
