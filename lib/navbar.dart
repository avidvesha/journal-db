
import 'package:flutter/material.dart';
import 'package:journal_coffee/home_page.dart';
import 'package:journal_coffee/profilepage.dart';

import 'cartpage.dart';

class navbar extends StatefulWidget {
  const navbar({Key? key}) : super(key: key);
  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    CartPage(),
    ProfilePage()
  ];

  void onBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onBarTapped,
        selectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled,), label: "Home"),
          // BottomNavigationBarItem(icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
