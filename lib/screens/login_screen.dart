import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mia_pos_v1/providers/app_state_provider.dart';
import 'package:mia_pos_v1/providers/dio_provider.dart';
import 'package:mia_pos_v1/providers/secure_storage_provider.dart';
import 'package:mia_pos_v1/widgets/figma_button.dart';
import 'package:mia_pos_v1/widgets/helper.dart';
import 'package:mia_pos_v1/widgets/mia_top_bar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final String terminalActivationId;

  const LoginScreen({
    super.key,
    required this.terminalActivationId,
  });

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String _username = "";
  String _password = "";

  void _activateTerminal() async {
    print(_username);
    print(_password);
    // await ref.read(secureStorageProvider).write(key: "terminalActivationId", value: "7a4a8ebb-99b6-4ef7-9dc8-b7959f095ede");
    try {
      final response = await ref.read(dioProvider).post(
        "/pos/api/v1/seller/login",
        data: {
          "terminalActivationId": widget.terminalActivationId,
          "username": _username,
          "password": _password,
        },
      );

      if (response.data == null) {
        showError(context, 'Error while performing request...');
        return;
      }

      if (response.data['result'] != 'success') {
        showError(context,
            'Error while performing request: ${response.data['result']}');
        return;
      }

      final tokens = response.data['authTokens'];
      int expiresIn = tokens['accessTokenExpiresIn'];

      ref.read(appStateProvider.notifier).updateTokens(
            accessToken: tokens['accessToken'],
            refreshToken: tokens['refreshToken'],
            expireTime: DateTime.now().add(Duration(seconds: expiresIn)),
            appState: CurrentState.authethicated,
          );
          
    } on DioException catch (ex) {
      print(ex);
      // TODO: depending on response, add different error messages
      showError(context, 'Error while performing request...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const MiaTopBar(),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              width: double.infinity,
              child: Text(
                'Sign into your account',
                style: GoogleFonts.onest(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: TextField(
                cursorColor: Colors.black,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Login',
                ),
                onChanged: (value) {
                  setState(() {
                    _username = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: TextField(
                cursorColor: Colors.black,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 28),
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: FigmaButton(
                onPressed: _activateTerminal,
                label: 'Enter',
                isDiactivated:
                    _username.trim().isEmpty || _password.trim().isEmpty,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
