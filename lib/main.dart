import 'package:flutter/material.dart';
import 'package:list_contacts_dio/pages/home/home.dart';
import 'package:list_contacts_dio/pages/save_contacts/save_contacts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    const SaveContacts(),
    const Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Lista de Contatos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Adcionar',
          ),
        ],
      ),
    );
  }
}
