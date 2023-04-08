import 'package:flutter/material.dart';
import 'package:journal_coffee/first_page.dart';
import 'package:journal_coffee/cartpage.dart';
import 'package:journal_coffee/payment_method.dart';

import 'home_page.dart';
import 'login_form.dart';
import 'navbar.dart';
import 'register_form.dart';
import 'first_page.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _FirstPageState();
}

class _FirstPageState extends State<Payment> {
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
                      MaterialPageRoute(builder: (context) => const PaymentMethod()),
                    );
                  },
                    icon:  Image.asset('assets/back_icon.png',
                      width: 150,),
                  ),
                  Padding(padding: EdgeInsets.all(5),
                    child: Text('Payment'),)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start  ,
              children: [
                Padding(padding: EdgeInsets.all(8),
                  child: Text(
                  "Cappuccino [Oat Milk] Rp. 30.000",
                  style: TextStyle(
                      height: 2, color: Colors.black, fontSize: 20, ),
                ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start  ,
              children: [
                Padding(padding: EdgeInsets.all(8),
                  child: Text(
                    "Taxx Rp. 2000",
                    style: TextStyle(
                      height: 2, color: Colors.black, fontSize: 20, ),
                  ),
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 50,  ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Cashh'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white54,
                      minimumSize: Size(160, 52),
                      onPrimary: Colors.black,
                  ),
                ),
              ],
            ),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 460, 0, 0),
                    alignment: AlignmentDirectional.centerStart,
                    height: 85,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                    ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8 ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 6 ),
                                    alignment: Alignment.bottomRight,
                                    // margin: EdgeInsets.symmetric(vertical: 2, horizontal: 1 ),
                                    child: Text(
                                      "Cash",
                                      style: TextStyle(
                                        height: 1, color: Colors.black, fontSize: 18, letterSpacing: 1,),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Container(
                                    // alignment: Alignment.topRight,
                                    // margin: EdgeInsets.symmetric(vertical: 2, horizontal: 15 ),
                                    child: Text(
                                      "Rp. 32.000",
                                      style: TextStyle(
                                          height: 1, color: Colors.black, fontSize: 18, letterSpacing: 1),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 6 ),
                              alignment: Alignment.bottomRight,
                              width: 150,

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Cash'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        minimumSize: Size(160, 52),
                                        onPrimary: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                      )
                  ),


          ],
        ),

      ),
    );
  }
}