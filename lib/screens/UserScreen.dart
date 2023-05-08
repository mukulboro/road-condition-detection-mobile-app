import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String _name = "huri poudel";
  String _email = "xyz@gmail.com";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                     //  Text("Tap to show image"),
                     // GalleryImage(
                     //     numOfShowImages: 1,
                     //     imageUrls: [
                     //       "https://www.google.com/search?tbm=isch&q=photo&tbs=imgo:1#imgrc=OJj5bbW_i6L-6M"
                     //     ],
                     // ),
                      CircleAvatar(
                        backgroundColor: Colors.purple,
                        minRadius: 80,
                        child: Icon(Icons.supervised_user_circle, size: 50, color: Colors.white,),
                      ),
                    ],
                  ),
                 const SizedBox(
                    height: 10,),
                  const Text("name",
                  style:  TextStyle(
                    fontSize: 20,
                    color: Colors.purple,
                    fontWeight: FontWeight.w500,
                  ),
                  ),
                   const Text("email",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.purple,
                      fontWeight: FontWeight.w500,
                    ),),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              width: 40,
              child: Center(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, "/welcome");
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, alignment: Alignment.topRight,),
                  child: const Text("Logout", textAlign: TextAlign.center,
                      style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 30,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
