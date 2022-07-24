import 'package:awesome_app/bg_image.dart';
import 'package:awesome_app/main.dart';
import 'package:awesome_app/utils/constants.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body:Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BgImage(),
           Center(
             child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Card(
              child: Column(
                children: <Widget>[
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Enter Username",
                              labelText: "Username",
                              ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                           TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Enter Password",
                              labelText: "Password",
                              ),
                          ),
                        ],
                      ), 
                    )
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: RaisedButton(
                    onPressed: () {
                      // Navigator.push(context,
                      //  MaterialPageRoute(
                      //   builder: (context) => HomePage()));
                      Constants.prefs.setBool("LoggedIn", true);
                      Navigator.pushReplacementNamed(context, "/home");
                    },
                    child: Text("Sign In"),
                    color: Colors.purple,
                    textColor: Colors.white,
                    ),
                 )
                ],
              ),
          ),
        ),
      ),
           ),
        ],
      )
    );
  }
}