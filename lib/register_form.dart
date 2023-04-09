import 'package:flutter/material.dart';

import 'auth.dart';
import 'first_page.dart';
import 'home_page.dart';
import 'navbar.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  var emailCon = TextEditingController();
  var passCon = TextEditingController();
  var nameCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      IconButton(onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const FirstPage()),
                        );
                      },
                        icon:  Image.asset('assets/back_icon.png',
                          width: 100,),
                      ),
                      Padding(padding: EdgeInsets.all(5),
                        child: Text('Back'),)
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextField(
                            controller: nameCon,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Name'
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextField(
                            controller: emailCon,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email'
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextField(
                            controller: passCon,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password'
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.brown[700],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            )
                        ),
                        onPressed: () async {
                          final message = await AuthService().registration(email: emailCon.text, password: passCon.text, username: nameCon.text);
                          if (message!.contains('Success')) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => navbar()));
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(message))
                          );
                        },
                        child: Center(
                            child: Text("Register")
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        )

    );
  }
}