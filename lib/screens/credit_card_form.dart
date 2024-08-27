import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:credit_card_scanner/credit_card_scanner.dart';
import '../models/credit_card_model.dart';
import '../services/card_validator.dart';
import '../services/storage_service.dart';
import '../utils/card_utils.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({super.key});

  @override
  CreditCardFormState createState() => CreditCardFormState();
}

class CreditCardFormState extends State<CreditCardForm> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cvvController = TextEditingController();
  final _issuingCountryController = TextEditingController();
  String _cardType = '';

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(_updateCardType);
  }

  void _updateCardType() {
    setState(() {
      _cardType = CardUtils.inferCardType(_cardNumberController.text);
    });
  }

  Future<void> _scanCard() async {
    try {
      final CardDetails? cardDetails = await CardScanner.scanCard();
      setState(() {
        _cardNumberController.text = cardDetails!.cardNumber;
        _cardType = CardUtils.inferCardType(cardDetails.cardNumber);
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error scanning card: $e');
      }
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final card = CreditCard(
        cardNumber: _cardNumberController.text,
        cardType: _cardType,
        cvv: _cvvController.text,
        issuingCountry: _issuingCountryController.text,
      );

      if (CardValidator.isValidCard(
          card.cardNumber, card.cvv, card.issuingCountry)) {
        StorageService.saveCard(card);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Card saved successfully')),
        );
        _formKey.currentState!.reset();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid card or banned country')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(labelText: 'Card Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text('Card Type: $_cardType'),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cvvController,
                decoration: const InputDecoration(labelText: 'CVV'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter CVV';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _issuingCountryController,
                decoration: const InputDecoration(labelText: 'Issuing Country'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter issuing country';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Align buttons to left and right
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.white, // Background color of the button
                      foregroundColor: Colors.teal, // Text and icon color
                      side: const BorderSide(
                        color: Colors.teal, // Teal border
                        width: 2.0, // Border width
                      ),
                    ),
                    onPressed: () {
                      _submitForm();
                    },
                    child: const Text('Submit'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.white, // Background color of the button
                      foregroundColor: Colors.teal, // Text and icon color
                      side: const BorderSide(
                        color: Colors.teal, // Teal border
                        width: 2.0, // Border width
                      ),
                    ),
                    onPressed: () {
                      _scanCard();
                    },
                    child: const Text('Scan Card'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
