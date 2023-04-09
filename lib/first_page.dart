import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_form.dart';
import 'navbar.dart';
import 'register_form.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // set it to false
      backgroundColor: Color.fromARGB(0, 28, 10, 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      SizedBox(height:25),
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Image.asset(
                          'assets/logo_landing.png',
                          width: 300,
                        ),
                      ),
                      SizedBox(height:10),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 122, 0, 0),
                    alignment: AlignmentDirectional.centerStart,
                    height: 450,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                backgroundColor: Colors.brown[700],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)
                                )
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginForm()),
                              );
                            },
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              backgroundColor: Colors.brown[700],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const RegisterForm()),
                              );
                            },
                            child: Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(height: 10,),
                        // TextButton(
                        //   onPressed: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) => const navbar()),
                        //     );
                        //   },
                        //   child: Text(
                        //     "Guest mode",
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 16,
                        //         color: Colors.black
                        //     ),
                        //   ),)

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}