import 'dart:convert';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:galleryimage/galleryimage.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key, this.credentials});

  final Credentials? credentials;

  @override
  State<UserScreen> createState() => _UserScreenState(credentials: credentials);
}

class _UserScreenState extends State<UserScreen> {
  _UserScreenState({this.credentials});

  Future<List> httpCall() async {
    String _email = credentials?.user.email ?? "";
    String _url = "http://192.168.18.13:8000";
    var url = Uri.parse("$_url/get_user_contibutions?username=$_email");
    var response = await http.get(url);
    var list = json.decode(response.body);
    list = list.map((value) => "$_url/view-image/$value").toList();
    return list;
  }

  late final Credentials? credentials;

  late Auth0 auth0;

  late List<String> listOfUrls;

  @override
  void initState() {
    super.initState();
    auth0 = Auth0('dev-ogxliul4ckys8nka.us.auth0.com',
        'Oj4ysiIMjqdv8wOUWUSs3Ot1WCrvvita');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: httpCall(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<String> contributions = List<String>.from(snapshot.data!);
            print(contributions[0]);
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      minRadius: 50,
                      backgroundColor: Colors.deepPurpleAccent,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.network(
                          credentials?.user.pictureUrl?.toString() ?? "",
                        ),
                      ),
                    ),
                    Text(
                      credentials?.user.name ?? "",
                      style: const TextStyle(
                          fontSize: 45, fontWeight: FontWeight.w200),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      credentials?.user.email ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blueGrey),
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 50,
                    ),
                    const Text(
                      "Your Contributions: ",
                    ),
                    GalleryImage(
                      titleGallery: "Your Contributions",
                      imageUrls: contributions,
                      numOfShowImages:
                          contributions.length < 4 ? contributions.length : 4,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 50,
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () async {
                          await auth0
                              .webAuthentication(scheme: "demo")
                              .logout();
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent),
                        child: const Text(
                          "Logout and Close",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
