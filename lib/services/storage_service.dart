import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/credit_card_model.dart';

class StorageService {
  static const String _key = 'credit_cards';

  static Future<void> saveCard(CreditCard card) async {
    final prefs = await SharedPreferences.getInstance();
    final cards = await getCards();

    if (!cards.any((c) => c.cardNumber == card.cardNumber)) {
      cards.add(card);
      await prefs.setString(
          _key, jsonEncode(cards.map((c) => c.toJson()).toList()));
    }
  }

  static Future<List<CreditCard>> getCards() async {
    final prefs = await SharedPreferences.getInstance();
    final cardsJson = prefs.getString(_key);
    if (cardsJson != null) {
      final cardsList = jsonDecode(cardsJson) as List;
      return cardsList.map((c) => CreditCard.fromJson(c)).toList();
    }
    return [];
  }
}
