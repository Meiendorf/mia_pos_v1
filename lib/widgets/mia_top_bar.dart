import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MiaTopBar extends StatelessWidget {
  const MiaTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
