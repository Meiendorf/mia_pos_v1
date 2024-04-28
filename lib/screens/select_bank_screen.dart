import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mia_pos_v1/data/const_data.dart';
import 'package:mia_pos_v1/widgets/figma_button.dart';

class SelectBankScreen extends StatefulWidget {
  const SelectBankScreen({super.key});

  @override
  State<SelectBankScreen> createState() => _SelectBankScreenState();
}

class _SelectBankScreenState extends State<SelectBankScreen> {
  String? _selectedBankId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 247, 249, 254),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: Color.fromRGBO(225, 230, 237, 1),
                      width: 0.5,
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(top: 110, bottom: 60),
                width: double.infinity,
                child: SvgPicture.asset(
                  'assets/images/mia.svg',
                  width: 158,
                  height: 28,
                ),
              ),
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
              padding: EdgeInsets.only(right: 10, left: 10),
              child: FigmaButton(
                onPressed: () {},
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
