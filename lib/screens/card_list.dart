import 'package:flutter/material.dart';
import '../models/credit_card_model.dart';
import '../services/storage_service.dart';

class CreditCardList extends StatefulWidget {
  const CreditCardList({super.key});

  @override
  CreditCardListState createState() => CreditCardListState();
}

class CreditCardListState extends State<CreditCardList> {
  List<CreditCard> _cards = [];

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    final cards = await StorageService.getCards();
    setState(() {
      _cards = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _cards.length,
      itemBuilder: (context, index) {
        final card = _cards[index];
        return ListTile(
          title: Text(
            'Card Number: ${card.cardNumber}',
          ),
          subtitle:
              Text('Type: ${card.cardType}, Country: ${card.issuingCountry}'),
        );
      },
    );
  }
}
