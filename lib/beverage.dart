import 'package:journal_coffee/choco.dart';
import 'package:journal_coffee/widget/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';

class BeveragePage extends StatefulWidget {
  const BeveragePage({Key? key}) : super(key: key);

  @override
  State<BeveragePage> createState() => _ChocoPageState();
}

class _ChocoPageState extends State<BeveragePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 140, width: double.infinity, color: Color.fromRGBO(29, 29, 29, 1),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                IconButton(onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const HomePage()),
                                  );
                                },
                                  icon:  Image.asset('assets/back_icon.png',
                                    width: 100, color: Colors.white,),
                                ),
                                Padding(padding: EdgeInsets.all(5),
                                  child: Text('Back', style: TextStyle(color: Colors.white),),)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            "Beverage",
                            style: GoogleFonts.montserrat(
                                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                      ],
                    )
                  ],
                ),


                CoffeShop(
                  imagePath: "assets/choco.png",
                  nameShop: "Beverage 1",
                ),
                CoffeShop(
                  imagePath: "assets/coffee4.png",
                  nameShop: "Beverage 2",
                ),
                CoffeShop(
                  imagePath: "assets/tea.png",
                  nameShop: "Beverage 3",
                ),
                CoffeShop(
                  imagePath: "assets/beverage.png",
                  nameShop: "Beverage 4",
                ),
              ],
            )),
      ),
    );
  }
}
