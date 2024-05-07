import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mia_pos_v1/data/const_data.dart';
import 'package:mia_pos_v1/providers/app_state_provider.dart';
import 'package:mia_pos_v1/screens/activate_terminal_screen.dart';
import 'package:mia_pos_v1/widgets/figma_button.dart';
import 'package:mia_pos_v1/widgets/mia_top_bar.dart';

class SelectBankScreen extends ConsumerStatefulWidget {
  const SelectBankScreen({super.key});

  @override
  ConsumerState<SelectBankScreen> createState() => _SelectBankScreenState();
}

class _SelectBankScreenState extends ConsumerState<SelectBankScreen> {
  String? _selectedBankId;

  void _onBankSelected() {
    if (_selectedBankId == null) {
      return;
    }
    
    ref.read(appStateProvider.notifier).updateSelectedBank(
        availableBanks.where((element) => element.id == _selectedBankId).first);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ActivateTerminalScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const MiaTopBar(),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                width: double.infinity,
                child: Text(
                  'Select bank partner',
                  style: GoogleFonts.onest(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: availableBanks.map(
                    (bank) {
                      Border border = Border(
                        bottom: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                          width: 0.5,
                        ),
                      );
                      if (bank.id == "1") {
                        border = Border.symmetric(
                          horizontal: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                            width: 0.5,
                          ),
                        );
                      }
                      Widget? trailing;
                      if (_selectedBankId == bank.id) {
                        trailing = SvgPicture.asset(
                          'assets/images/checkmark.svg',
                          width: 16,
                          height: 11,
                        );
                      }
                      return ListTile(
                        onTap: () {
                          setState(() {
                            _selectedBankId = bank.id;
                          });
                        },
                        shape: border,
                        title: Text(bank.name),
                        trailing: trailing,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image.asset(
                            bank.imagePath,
                            width: 28,
                            height: 28,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: FigmaButton(
                onPressed: _onBankSelected,
                label: 'Next',
                isDiactivated: _selectedBankId == null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
