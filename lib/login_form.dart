import 'package:flutter/material.dart';
import 'package:journal_coffee/auth.dart';
import 'package:journal_coffee/home_page.dart';

import 'first_page.dart';
import 'navbar.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  var emailCon = TextEditingController();
  var passCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
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
                          width: 150,),
                      ),
                      Padding(padding: EdgeInsets.all(5),
                        child: Text('Back'),)
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 86,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                              controller: emailCon,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email'
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:0),
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
                              obscureText: true,
                              controller: passCon,
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
                            final message = await AuthService().login(email: emailCon.text, password: passCon.text);
                            if (message!.contains('Success')) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => navbar()));
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(message))
                            );
                          },
                          child: Center(
                              child: Text("Login")
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )

    );
  }
}