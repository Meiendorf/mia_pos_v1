import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mia_pos_v1/providers/app_state_provider.dart';
import 'package:mia_pos_v1/providers/dio_provider.dart';
import 'package:mia_pos_v1/providers/secure_storage_provider.dart';
import 'package:mia_pos_v1/screens/main_screen.dart';
import 'package:mia_pos_v1/widgets/helper.dart';
import 'package:mia_pos_v1/widgets/mia_top_bar.dart';

class ActivateTerminalOtp extends ConsumerStatefulWidget {
  final String activationId;
  final String maskedPhone;
  final int waitTimeToResend;

  const ActivateTerminalOtp({
    super.key,
    required this.activationId,
    required this.maskedPhone,
    required this.waitTimeToResend,
  });

  @override
  ConsumerState<ActivateTerminalOtp> createState() {
    return _ActivateTerminalOtpState();
  }
}

class _ActivateTerminalOtpState extends ConsumerState<ActivateTerminalOtp> {
  Timer? _timer;
  late int _secondsLeft;
  bool _isLoading = false;
  bool _isOtpError = false;

  @override
  void initState() {
    super.initState();
    _secondsLeft = widget.waitTimeToResend;
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _secondsLeft = widget.waitTimeToResend;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsLeft--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _sendOtp(String otp) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await ref.read(dioProvider).post(
        "/pos/api/v1/terminal-activation/confirm",
        data: {
          "terminalActivationId": widget.activationId,
          "otpCode": otp,
        },
      );
      setState(() {
        _isLoading = false;
      });

      // TODO: show remaining attempts, show errors below otp

      if (response.data == null) {
        showError(context, 'Error while confirming otp...');
        return;
      }

      if (response.data['result'] != 'success') {
        setState(() {
          _isOtpError = true;
        });
        showError(
          context,
          'Error while confirming otp: ${response.data['result']}',
        );
        return;
      }

      print(response);
      // showError(
      //   context,
      //   'Success',
      // );

      final secureStorage = ref.read(secureStorageProvider);
      await secureStorage.write(
        key: 'terminalActivationId',
        value: widget.activationId,
      );
      await secureStorage.write(
        key: 'selectedBankId',
        value: ref.read(appStateProvider).selectedBank?.id,
      );
      await secureStorage.write(
        key: 'appState',
        value: CurrentState.login.toString(),
      );

      // ref.read(appStateProvider.notifier).updateAppState(CurrentState.login);
      ref.read(appStateProvider.notifier).updateAppState(CurrentState.login);
      ref.read(appStateProvider.notifier).updateTerminalActivationId(widget.activationId);
      Navigator.of(context).popUntil((route) => false);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const MainScreen(),
        ),
      );
    } on DioException catch (ex) {
      setState(() {
        _isLoading = false;
      });
      print(ex);
      showError(context, 'Error while confirming otp...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(children: [
              const MiaTopBar(),
              Positioned(
                top: 20.0,
                left: 00.0,
                child: IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ]),
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
                'Enter OTP code code sent to ${widget.maskedPhone}',
                style: GoogleFonts.onest(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: const Color.fromRGBO(91, 99, 109, 1),
                ),
              ),
            ),
            if (_isLoading)
              Container(
                margin: EdgeInsets.all(6),
                child: CircularProgressIndicator(
                  color: const Color.fromRGBO(66, 120, 227, 1),
                ),
              ),
            if (!_isLoading)
              OtpTextField(
                numberOfFields: 6,
                borderWidth: 1,
                borderColor: const Color.fromRGBO(47, 128, 237, 1),
                enabledBorderColor: !_isOtpError
                    ? const Color(0xFFE7E7E7)
                    : const Color.fromRGBO(211, 47, 47, 1),
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
                  _sendOtp(verificationCode);
                }, // end onSubmit
              ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 20, bottom: 28),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 18,
                    child: Text(
                      'Didn' 't recieve the code?',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(143, 140, 155, 1),
                          ),
                    ),
                  ),
                  if (_secondsLeft > 0)
                    Container(
                      height: 18,
                      child: Text(
                        ' Resend it after ${_secondsLeft}s...',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(143, 140, 155, 1),
                            ),
                      ),
                    ),
                  if (_secondsLeft == 0)
                    Container(
                      height: 18,
                      margin: EdgeInsets.only(left: 3),
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          // _startTimer();
                          setState(() {
                            _isLoading = !_isLoading;
                          });
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          foregroundColor:
                              const Color.fromRGBO(66, 120, 227, 1),
                        ),
                        child: Text(
                          'Resend',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(66, 120, 227, 1),
                              ),
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
