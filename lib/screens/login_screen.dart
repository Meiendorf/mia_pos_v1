import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mia_pos_v1/providers/secure_storage_provider.dart';
import 'package:mia_pos_v1/widgets/figma_button.dart';
import 'package:mia_pos_v1/widgets/mia_top_bar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
              child: const TextField(
                  cursorColor: Colors.black,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: 'Login',
                  )),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: const TextField(
                  cursorColor: Colors.black,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  )),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 28),
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: FigmaButton(
                onPressed: () async {
                  print(await ref.read(secureStorageProvider).read(key: 'terminalActivationId'));
                },
                label: 'Enter',
                isDiactivated: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
