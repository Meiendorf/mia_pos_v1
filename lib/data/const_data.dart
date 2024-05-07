import 'package:mia_pos_v1/models/bank_option.dart';

const availableBanks = [
  BankOption(
    id: '1',
    imagePath: 'assets/images/banks/micb.png',
    name: 'MICB',
    apiBaseUrl: 'https://mia.redriverapps.net',
  ),
  BankOption(
    id: '2',
    imagePath: 'assets/images/banks/maib.png',
    name: 'MAIB',
    apiBaseUrl: 'https://mia.redriverapps.net',
  ),
  BankOption(
    id: '3',
    imagePath: 'assets/images/banks/victoria.png',
    name: 'VictoriaBank',
    apiBaseUrl: 'https://mia.redriverapps.net',
  ),
   BankOption(
    id: '4',
    imagePath: 'assets/images/banks/energ.png',
    name: 'Energbank',
    apiBaseUrl: 'https://mia.redriverapps.net',
  ),
];
