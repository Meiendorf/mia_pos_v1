import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mia_pos_v1/widgets/figma_button.dart';

class TerminalAmountScreen extends StatelessWidget {
  final isOpenDay = true;

  const TerminalAmountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
              bottom: 16,
            ),
            child: Text(
              '"ULTRA DISTRIBUTION" S.R.L, str. Ion Creanga, 6V.CASA NR. 2',
              textAlign: TextAlign.center,
              style: GoogleFonts.onest(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Color.fromRGBO(91, 99, 109, 1),
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 28),
            padding: const EdgeInsets.only(right: 12, left: 12, bottom: 24),
            child: FigmaButton(
              onPressed: () {},
              label: 'Send to pay',
              isDiactivated: false,
            ),
          ),
        ],
      ),
    );
  }
}
