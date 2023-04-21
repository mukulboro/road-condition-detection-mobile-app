import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _enteredUsername = "";
  String _enteredName = "";
  String _enteredPassword = "";
  String _enteredConfirmPassword = "";

  void _handleRegisterPress() {
    const snackBar = SnackBar(
      backgroundColor: Colors.deepOrange,
      content: Text(
        'Please wait, registering your account...',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // TODO: Handle user registration
    print("password: $_enteredPassword");
    print("uname: $_enteredUsername");
    if (true) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      const newSnackBar = SnackBar(
        backgroundColor: Colors.teal,
        content: Text(
          'Registration Successful! Please Login to continue',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(newSnackBar);
      Navigator.pushNamed(context, "/login");
    }
  }

  void _handleLoginPress() {
    Navigator.pushNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                "WELCOME!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                child: Text(
                  "Register new account",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: SizedBox(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        onChanged: (input) {
                          _enteredName = input;
                        },
                        decoration: const InputDecoration(
                            hintText: "Full Name",
                            labelText: "Full Name",
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            iconColor: Colors.blue,
                            icon: Icon(Icons.person)),
                      ),
                      const SizedBox(width: double.infinity, height: 15),
                      TextField(
                        onChanged: (input) {
                          _enteredUsername = input;
                        },
                        decoration: const InputDecoration(
                            hintText: "Username",
                            labelText: "Username",
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            iconColor: Colors.blue,
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
                                borderSide:
                                    BorderSide(color: Colors.blueAccent)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            iconColor: Colors.blue,
                            icon: Icon(Icons.lock)),
                      ),
                      const SizedBox(width: double.infinity, height: 15),
                      TextField(
                        onChanged: (input) {
                          _enteredConfirmPassword = input;
                        },
                        decoration: const InputDecoration(
                            hintText: "Confirm Password",
                            labelText: "Confirm Password",
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            iconColor: Colors.blue,
                            icon: Icon(Icons.password_outlined)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    _handleRegisterPress();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                  child: const Text(
                    "REGISTER",
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
                    "Already have an account?",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  )),
              GestureDetector(
                child: const Text(
                  "Login to account",
                  style: TextStyle(color: Colors.purpleAccent),
                ),
                onTap: () {
                  _handleLoginPress();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
