import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mia_pos_v1/providers/secure_storage_provider.dart';
import 'package:mia_pos_v1/screens/activate_terminal_otp.dart';
import 'package:mia_pos_v1/screens/active_terminal_screen.dart';
import 'package:mia_pos_v1/screens/login_screen.dart';
import 'package:mia_pos_v1/screens/select_bank_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {

  @override
  void initState() {

    super.initState();
  }

  void initApp() async {
    final secureStorage = ref.read(secureStorageProvider);
    
  }

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
