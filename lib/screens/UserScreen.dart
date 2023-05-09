import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galleryimage/galleryimage.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key, this.credentials});

  final Credentials? credentials;

  @override
  State<UserScreen> createState() => _UserScreenState(credentials: credentials);
}

class _UserScreenState extends State<UserScreen> {
  _UserScreenState({this.credentials});

  late final Credentials? credentials;

  late Auth0 auth0;

  late List<String> listOfUrls;

  @override
  void initState() {
    super.initState();
    auth0 = Auth0('dev-ogxliul4ckys8nka.us.auth0.com',
        'Oj4ysiIMjqdv8wOUWUSs3Ot1WCrvvita');
    listOfUrls = [
      "https://cosmosmagazine.com/wp-content/uploads/2020/02/191010_nature.jpg",
      "https://scx2.b-cdn.net/gfx/news/hires/2019/2-nature.jpg",
      "https://cosmosmagazine.com/wp-content/uploads/2020/02/191010_nature.jpg",
      "https://scx2.b-cdn.net/gfx/news/hires/2019/2-nature.jpg",
      "https://cosmosmagazine.com/wp-content/uploads/2020/02/191010_nature.jpg",
      "https://scx2.b-cdn.net/gfx/news/hires/2019/2-nature.jpg",
      "https://cosmosmagazine.com/wp-content/uploads/2020/02/191010_nature.jpg",
      "https://scx2.b-cdn.net/gfx/news/hires/2019/2-nature.jpg",
    ];
  }

  @override
  Widget build(BuildContext context) {
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
              style: const TextStyle(fontSize: 45, fontWeight: FontWeight.w200),
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
              imageUrls: listOfUrls,
              titleGallery: "Your Contributions",
            ),
            const SizedBox(
              width: double.infinity,
              height: 50,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () async {
                  await auth0.webAuthentication(scheme: "demo").logout();
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
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
}
