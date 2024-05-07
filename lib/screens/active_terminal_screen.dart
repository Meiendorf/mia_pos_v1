import 'package:flutter/material.dart';

class ActiveTerminalScreen extends StatefulWidget {
  const ActiveTerminalScreen({super.key});

  @override
  State<ActiveTerminalScreen> createState() {
    return _ActiveTerminalScreenState();
  }
}

class _ActiveTerminalScreenState extends State<ActiveTerminalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terminal'),
      ),
      body: Center(
        child: const Text('Terminal activated!'),
      ),
    );
  }
}
