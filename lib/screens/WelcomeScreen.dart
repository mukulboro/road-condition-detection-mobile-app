import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void _handleLoginPress(){
    Navigator.pushNamed(context, "/login");
  }

  void _handleRegisterPress(){
    Navigator.pushNamed(context, "/register");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            const Text("Welcome Screen"),
            SizedBox(
              width: 300,
              child: ElevatedButton(style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,),
                  onPressed: (){
                    _handleLoginPress();
                  },
                  child: const Text("LOGIN",
                    style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 4
                    ),
                  ),
              ),
            ),

            SizedBox(
              width: 300,
              child: ElevatedButton(style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,),
                  onPressed: (){
                    _handleRegisterPress();
                  },
                  child: const Text("REGISTER",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 4
                  ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
