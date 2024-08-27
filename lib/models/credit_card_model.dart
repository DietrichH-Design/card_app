class CreditCard {
  final String cardNumber;
  final String cardType;
  final String cvv;
  final String issuingCountry;

  CreditCard({
    required this.cardNumber,
    required this.cardType,
    required this.cvv,
    required this.issuingCountry,
  });

  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'cardType': cardType,
      'cvv': cvv,
      'issuingCountry': issuingCountry,
    };
  }

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      cardNumber: json['cardNumber'],
      cardType: json['cardType'],
      cvv: json['cvv'],
      issuingCountry: json['issuingCountry'],
    );
  }
}
