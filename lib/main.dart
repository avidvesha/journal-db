import 'package:coffee_shop_youtube/home_page.dart';
import 'package:flutter/material.dart';

import 'first_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
            home: FirstPage(),
    );
  }
}
