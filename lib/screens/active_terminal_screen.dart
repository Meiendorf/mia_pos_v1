import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mia_pos_v1/providers/dio_provider.dart';

class ActiveTerminalScreen extends ConsumerStatefulWidget {
  const ActiveTerminalScreen({super.key});

  @override
  ConsumerState<ActiveTerminalScreen> createState() {
    return _ActiveTerminalScreenState();
  }
}

class _ActiveTerminalScreenState extends ConsumerState<ActiveTerminalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terminal'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text('Terminal activated!'),
          TextButton(
            onPressed: () async {
              // await ref.read(secureStorageProvider).write(key: 'appState', value: CurrentState.login.toString());
              final response = await ref.read(authDioProvider).get('/pos/api/v1/shift/check');
              print(response.data);
              print('hellloo');
            },
            child: Text('Tap me'),
          )
        ],
      ),
    );
  }
}
