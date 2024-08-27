import 'package:card_app/screens/card_list.dart';
import 'package:flutter/material.dart';
import 'screens/credit_card_form.dart';

void main() {
  runApp(const CreditCardApp());
}

class CreditCardApp extends StatelessWidget {
  const CreditCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Card App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CreditCardHome(),
    );
  }
}

class CreditCardHome extends StatefulWidget {
  const CreditCardHome({super.key});

  @override
  CreditCardHomeState createState() => CreditCardHomeState();
}

class CreditCardHomeState extends State<CreditCardHome> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const CreditCardForm(),
    const CreditCardList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal, // Background color of the AppBar
        title: const Text(
          'Credit Card App',
          style: TextStyle(color: Colors.white), // White text
        ),
        centerTitle: true,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: Colors.teal,
              size: 44,
            ),
            label: 'Add Card',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              color: Colors.teal,
              size: 44,
            ),
            label: 'Card List',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
