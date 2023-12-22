import 'package:intl/intl.dart';

class HumanFormats {
  static String humanReadableNumber(double number) {
    final formatedNumber = NumberFormat.compactCurrency(decimalDigits: 0, symbol: '', locale: 'en').format(number);
    return formatedNumber;
  }
}
