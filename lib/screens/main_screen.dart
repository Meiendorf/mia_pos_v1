import 'package:flutter/material.dart';
import 'package:mia_pos_v1/screens/activate_terminal_otp.dart';
import 'package:mia_pos_v1/screens/active_terminal_screen.dart';
import 'package:mia_pos_v1/screens/login_screen.dart';
import 'package:mia_pos_v1/screens/select_bank_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SelectBankScreen();
  }
}
