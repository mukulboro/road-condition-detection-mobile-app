import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _enteredUsername = "";
  String _enteredPassword = "";

  void _handleLoginPress() {
    const snackBar = SnackBar(
      backgroundColor: Colors.indigo,
      content: Text(
        'Please wait, logging you in...',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // TODO: Handle user login
    print("password: $_enteredPassword");
    print("uname: $_enteredUsername");
    if (true) {
      Navigator.pushNamed(context, "/home");
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }

  void _handleRegisterPress() {
    Navigator.pushNamed(context, "/register");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: Image(
                image: NetworkImage(
                    "https://www.edigitalagency.com.au/wp-content/uploads/Twitter-logo-png.png"),
                width: 100,
              ),
            ),
            const Text(
              "WELCOME BACK!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Text(
                "Login using your credentials",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      onChanged: (input) {
                        _enteredUsername = input;
                      },
                      decoration: const InputDecoration(
                          hintText: "Username",
                          labelText: "Username",
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightGreen)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          iconColor: Colors.teal,
                          icon: Icon(Icons.alternate_email)),
                    ),
                    const SizedBox(width: double.infinity, height: 15),
                    TextField(
                      onChanged: (input) {
                        _enteredPassword = input;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: "Password",
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightGreen)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          iconColor: Colors.teal,
                          icon: Icon(Icons.lock)),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  _handleLoginPress();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple),
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 4),
                ),
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 1),
                child: Text(
                  "Don't have an account?",
                  style: TextStyle(fontWeight: FontWeight.w300),
                )),
            GestureDetector(
              child: const Text(
                "Register Now",
                style: TextStyle(color: Colors.deepOrange),
              ),
              onTap: () {
                _handleRegisterPress();
              },
            )
          ],
        ),
      ),
    );
  }
}
