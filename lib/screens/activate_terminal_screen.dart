import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mia_pos_v1/providers/app_state_provider.dart';
import 'package:mia_pos_v1/providers/dio_provider.dart';
import 'package:mia_pos_v1/screens/activate_terminal_otp.dart';
import 'package:mia_pos_v1/widgets/figma_button.dart';
import 'package:mia_pos_v1/widgets/helper.dart';
import 'package:mia_pos_v1/widgets/mia_top_bar.dart';

class ActivateTerminalScreen extends ConsumerStatefulWidget {
  const ActivateTerminalScreen({super.key});

  @override
  ConsumerState<ActivateTerminalScreen> createState() =>
      _ActivateTerminalScreenState();
}

class _ActivateTerminalScreenState
    extends ConsumerState<ActivateTerminalScreen> {
  String _enteredIdno = "";
  String _enteredTerminalId = "";

  void _activateTerminal() async {
    print(_enteredIdno);
    print(_enteredTerminalId);
    print(ref.read(appStateProvider).selectedBank?.name);

    try {
      final response = await ref.read(dioProvider).post(
        "/pos/api/v1/terminal-activation/init",
        options: Options(
          headers: {
            // TODO: pass here right params
            'X-DEVICE': 'Flutter Emulator',
            'X-PLATFORM-TYPE': 'android',
            'X-INSTALLATION-ID': '628f8a47-50a4-47e4-be12-af6c4dac9573',
            'X-POS-APP-VERSION': '101'
          },
        ),
        data: {
          "terminalId": _enteredTerminalId,
          "merchantIdno": _enteredIdno,
        },
      );

      if (response.data == null) {
        showError(context, 'Error while performing request...');
        return;
      }

      if (response.data['result'] == 'otp_limit_exceeded') {
        showError(context, 'OTP sending limit was exceeded...');
        return;
      }

      if (response.data['result'] == 'not_found' ||
          response.data['result'] == 'not_assign') {
        showError(context,
            'Invalid terminal credentials. Please make sure you have entered the terminal ID and IDNO correctly and try again.');
        return;
      }

      if (response.data['result'] != 'success') {
        showError(context, 'Error while performing request...');
        return;
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ActivateTerminalOtp(
            activationId: response.data['terminalActivationId'],
            maskedPhone: response.data['maskedPhoneNumber'],
            waitTimeToResend: response.data['waitTimeToResend'],
          ),
        ),
      );
    } on DioException catch (ex) {
      print(ex);
      // TODO: depending on response, add different error messages
      showError(context,
          'Invalid terminal credentials. Please make sure you have entered the terminal ID and IDNO correctly and try again.');
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
                'Enter data about your terminal',
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
                  labelText: 'IDNO',
                ),
                onChanged: (value) {
                  setState(() {
                    _enteredIdno = value;
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
                  labelText: 'Terminal ID',
                ),
                onChanged: (value) {
                  setState(() {
                    _enteredTerminalId = value;
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
                label: 'Next',
                isDiactivated: _enteredIdno.trim().isEmpty ||
                    _enteredTerminalId.trim().isEmpty,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
