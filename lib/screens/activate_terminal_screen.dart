import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mia_pos_v1/widgets/figma_button.dart';
import 'package:mia_pos_v1/widgets/mia_top_bar.dart';

class ActivateTerminalScreen extends ConsumerStatefulWidget {
  const ActivateTerminalScreen({super.key});

  @override
  ConsumerState<ActivateTerminalScreen> createState() =>
      _ActivateTerminalScreenState();
}

class _ActivateTerminalScreenState
    extends ConsumerState<ActivateTerminalScreen> {
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
              child: const TextField(
                cursorColor: Colors.black,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'IDNO',
                )
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: const TextField(
                cursorColor: Colors.black,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Terminal ID',
                )
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 28),
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: FigmaButton(
                onPressed: () {},
                label: 'Next',
                isDiactivated: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
