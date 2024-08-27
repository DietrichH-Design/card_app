class CardUtils {
  static String inferCardType(String cardNumber) {
    // Implement card type inference logic here
    if (cardNumber.startsWith('4')) {
      return 'Visa';
    } else if (cardNumber.startsWith('5')) {
      return 'MasterCard';
    } else if (cardNumber.startsWith('3')) {
      return 'American Express';
    } else {
      return 'Unknown';
    }
  }
}
