import 'package:intl/intl.dart';

class HumanFormats {
  static String humanReadableNumber(double number, [int decimals = 0]) {
    final formatedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
       symbol: '', 
       locale: 'en')
       .format(number);

    return formatedNumber;
  }
}
