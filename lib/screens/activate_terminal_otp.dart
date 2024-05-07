import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mia_pos_v1/widgets/mia_top_bar.dart';

class ActivateTerminalOtp extends ConsumerStatefulWidget {
  const ActivateTerminalOtp({super.key});

  @override
  ConsumerState<ActivateTerminalOtp> createState() {
    return _ActivateTerminalOtpState();
  }
}

class _ActivateTerminalOtpState extends ConsumerState<ActivateTerminalOtp> {
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
              padding: const EdgeInsets.only(top: 98, bottom: 0),
              width: double.infinity,
              child: Text(
                'OTP confirmation',
                style: GoogleFonts.onest(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 4, bottom: 28),
              width: double.infinity,
              child: Text(
                'Enter OTP code code sent to +373 ******24',
                style: GoogleFonts.onest(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: const Color.fromRGBO(91, 99, 109, 1),
                ),
              ),
            ),
            OtpTextField(
              numberOfFields: 6,
              borderColor: const Color.fromRGBO(47, 128, 237, 1),
              filled: true,
              fillColor: const Color.fromRGBO(250, 251, 252, 1),
              focusedBorderColor: const Color.fromRGBO(47, 128, 237, 1),
              cursorColor: const Color.fromRGBO(204, 211, 221, 1),
              keyboardType: TextInputType.number,
              autoFocus: true,
              showFieldAsBox: true,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              fieldWidth: 48,
              fieldHeight: 48,
              contentPadding: const EdgeInsets.only(
                left: 0,
                top: 12,
              ),
              textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
              onSubmit: (String verificationCode) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Verification Code"),
                        content: Text('Code entered is $verificationCode'),
                      );
                    });
              }, // end onSubmit
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 4, bottom: 28),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn' 't recieve the code?',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(143, 140, 155, 1),
                        ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(0),
                      foregroundColor: const Color.fromRGBO(66, 120, 227, 1),
                    ),
                    child: Text(
                      'Resend',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(66, 120, 227, 1),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
