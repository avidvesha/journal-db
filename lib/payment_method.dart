import 'package:flutter/material.dart';
import 'package:journal_coffee/first_page.dart';
import 'package:journal_coffee/cartpage.dart';
import 'package:journal_coffee/payment.dart';

import 'home_page.dart';
import 'login_form.dart';
import 'navbar.dart';
import 'register_form.dart';
import 'first_page.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  State<PaymentMethod> createState() => _FirstPageState();
}

class _FirstPageState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // set it to false
      // backgroundColor: Color.fromARGB(0, 28, 10, 0),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  IconButton(onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const CartPage()),
                    );
                  },
                    icon:  Image.asset('assets/back_icon.png',
                      width: 150,),
                  ),
                  Padding(padding: EdgeInsets.all(5),
                    child: Text('Payment Method'),)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Available Payment",
                  style: TextStyle(
                      height: 2, color: Color(0x9c9c9c9c), fontSize: 20),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 50,  ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Cash'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white54,
                        minimumSize: Size(160, 52),
                        onPrimary: Colors.black
                    ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 15 ,  ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Payment()),
                    );
                  },
                  child: const Text('E-Money'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white54,
                    minimumSize: Size(160, 52),
                    onPrimary: Colors.black
                  ),
                ),
              ],
            ),
          ],
        ),

      ),
    );
  }
}