import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mia_pos_v1/terminal_flow/terminal_amount_screen.dart';

class ActiveTerminalScreen extends ConsumerStatefulWidget {
  const ActiveTerminalScreen({super.key});

  @override
  ConsumerState<ActiveTerminalScreen> createState() {
    return _ActiveTerminalScreenState();
  }
}

class _ActiveTerminalScreenState extends ConsumerState<ActiveTerminalScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MainAppBarTitle(),
        backgroundColor: Colors.white,
        shadowColor: const Color.fromRGBO(1, 20, 52, 0.12),
        elevation: 3.0,
        surfaceTintColor: Colors.white,
      ),
      body: const TerminalAmountScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        unselectedLabelStyle: GoogleFonts.onest(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        selectedLabelStyle: GoogleFonts.onest(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        selectedItemColor: Color.fromRGBO(47, 128, 237, 1),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/terminal_icon.svg'),
            label: 'Terminal',
            activeIcon: SvgPicture.asset(
              'assets/images/terminal_icon.svg',
              color: const Color.fromRGBO(47, 128, 237, 1),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/tx_icon.svg'),
            label: 'Transactions',
            activeIcon: SvgPicture.asset(
              'assets/images/tx_icon.svg',
              color: const Color.fromRGBO(47, 128, 237, 1),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/profile_tab_icon.svg'),
            label: 'Profile',
            activeIcon: SvgPicture.asset(
              'assets/images/profile_tab_icon.svg',
              color: const Color.fromRGBO(47, 128, 237, 1),
            ),
          ),
        ],
      ),
    );
  }
}

class MainAppBarTitle extends StatelessWidget {
  const MainAppBarTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Terminal',
          style: GoogleFonts.onest(
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '(id: 56145)',
          style: GoogleFonts.onest(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: const Color.fromRGBO(140, 150, 155, 1),
          ),
        ),
      ],
    );
  }
}
