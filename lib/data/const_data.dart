import 'package:mia_pos_v1/models/bank_option.dart';

const availableBanks = [
  BankOption(
    id: '1',
    imagePath: 'assets/images/banks/micb.png',
    name: 'MICB',
    apiBaseUrl: 'someUrl',
  ),
  BankOption(
    id: '2',
    imagePath: 'assets/images/banks/maib.png',
    name: 'MAIB',
    apiBaseUrl: 'someUrl',
  ),
  BankOption(
    id: '3',
    imagePath: 'assets/images/banks/victoria.png',
    name: 'VictoriaBank',
    apiBaseUrl: 'someUrl',
  ),
   BankOption(
    id: '4',
    imagePath: 'assets/images/banks/energ.png',
    name: 'Energbank',
    apiBaseUrl: 'someUrl',
  ),
];
