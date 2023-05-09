import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:road_condition_mapping/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({required this.camera});

  final CameraDescription camera;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState(camera: camera);
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  _WelcomeScreenState({required this.camera});

  final CameraDescription camera;

  Credentials? _credentials;
  late Auth0 auth0;
  String? token;
  String? userEmail;

  Future<String?> getToken() async {
    return await storage.read(key: "loginToken");
  }

  Future<String?> getUser() async {
    return await storage.read(key: "userEmail");
  }

  @override
  void initState() {
    super.initState();
    auth0 = Auth0('dev-ogxliul4ckys8nka.us.auth0.com',
        'Oj4ysiIMjqdv8wOUWUSs3Ot1WCrvvita');
    getToken().then((value) => {
          setState(() {
            token = value;
          })
        });

    getUser().then((value) => setState(() {
          userEmail = value;
        }));
  }

  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "WELCOME TO",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const Text(
              "SadakVision",
              style: TextStyle(
                  fontSize: 50, fontWeight: FontWeight.w200, letterSpacing: 3),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Image(
                image: AssetImage('assets/SadakVision_logo.png'),
                height: 200,
              ),
            ),
            SizedBox(
              width: 300,
              child: _credentials == null && token == null
                  ? ElevatedButton(
                      onPressed: () async {
                        final credentials = await auth0
                            .webAuthentication(scheme: "demo")
                            .login();

                        setState(() {
                          _credentials = credentials;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple),
                      child: const Text(
                        "GET STARTED",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w300),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return HomePage(
                            camera: camera,
                            credentials: _credentials,
                          );
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple),
                      child: const Text(
                        "PROCEED TO APP",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
            ),
            userEmail == null ? const Text("") : Text("Logged in as $userEmail")
          ],
        ),
      ),
    );
  }
}
