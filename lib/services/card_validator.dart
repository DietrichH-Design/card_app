import '../config/banned_countries.dart';

class CardValidator {
  static bool isValidCard(
      String cardNumber, String cvv, String issuingCountry) {
    // Implement card validation logic here
    return cardNumber.length >= 13 &&
        cardNumber.length <= 19 &&
        cvv.length >= 3 &&
        cvv.length <= 4 &&
        !bannedCountries.contains(issuingCountry);
  }
}
