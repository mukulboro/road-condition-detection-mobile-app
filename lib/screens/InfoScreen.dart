import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[1000],
      body: SingleChildScrollView(
        padding:const  EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/SadakVision_logo.png'),
                radius: 60,
              ),
            ),
           const  SizedBox(
              height: 10,
            ),
            const Center(
                child: Text('SadakVision',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                    fontSize: 35,
                ),
                ),
            ),

            Divider(
              height: 50,
              color: Colors.grey[500],
            ),

            Center(
              child: GestureDetector(
                onTap: () async {
                  var url = "https://github.com/mukulboro/road-condition-detection-mobile-app";
                  await launch(url);
                },
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: const <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/github.png'),
                          radius: 20,
                        ),
                        title: Text('Mobile Application Repository',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        subtitle:
                        Text('road-condition-detection-mobile-app',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white54
                          ),
                        ),

                            ),
                    ],
                  ),
                ),
              ),
            ),

            Center(
              child: GestureDetector(
                onTap: () async {
                  var url = "https://github.com/mukulboro/road-condition-detection-webserver";
                  await launch(url);
                },
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: const <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/github.png'),
                          radius: 20,
                        ),
                        title: Text('Web Server Repository',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        subtitle:
                        Text('road-condition-detection-mobile-app',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white54
                          ),
                        ),

                      ),
                    ],
                  ),
                ),
              ),
            ),

            Divider(
              height: 50,
              color: Colors.grey[500],
            ),


           const Text('DEVELOPERS',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            ),

            const SizedBox(
              height: 30,
            ),

// -------------------------------------MUKUL ARYAL ----------------------------------------------

            Center(
              child: Column(
                children:  <Widget> [
                  const SizedBox(
                    height: 65,
                    width: 65,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/ma.jpg'),
                      radius: 50,
                    ),
                  ),
                   const Text('Mukul Aryal', textAlign: TextAlign.right,

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      wordSpacing: 1,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                          child: const CircleAvatar(
                            backgroundImage: AssetImage('assets/github.png'),
                            // radius: 100,
                          ),
                          onPressed: ()async{
                            var url = "https://github.com/mukulboro";
                            await launch(url);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                          child: const Icon(
                            FontAwesomeIcons.globe,
                            size: 35,
                          ),
                          onPressed: ()async{
                            var url = "https://www.mukul.com.np/";
                            await launch(url);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                          child: const Icon(
                              FontAwesomeIcons.instagram,
                          size: 35,
                          ),
                          onPressed: ()async{
                            var url = "https://www.instagram.com/aryalmukul/";
                            await launch(url);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                          child: const Icon(
                            FontAwesomeIcons.facebook,
                            size: 35,
                          ),
                          onPressed: ()async{
                            var url = "https://www.facebook.com/aryalmukul";
                            await launch(url);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 30,
            ),

// ------------------BIGYA VIJAY DHUNGANA-----------------------------------------------------------------------------------------

            Center(
              child: Column(
                children:  <Widget> [
                  const SizedBox(
                    height: 65,
                    width: 65,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/bvd.jpg'),
                      radius: 50,
                    ),
                  ),
                  const Text('Bigya Vijay Dhungana', textAlign: TextAlign.right,

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      wordSpacing: 1,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                          child: const CircleAvatar(
                            backgroundImage: AssetImage('assets/github.png'),
                            // radius: 100,
                          ),
                          onPressed: ()async{
                            var url = "https://github.com/BigyaDhungana";
                            await launch(url);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                          child: const Icon(
                            FontAwesomeIcons.linkedinIn,
                            size: 35,
                          ),
                          onPressed: ()async{
                            var url = "https://www.linkedin.com/in/bigya-dhungana-203426276/";
                            await launch(url);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                          child: const Icon(
                            FontAwesomeIcons.instagram,
                            size: 35,
                          ),
                          onPressed: ()async{
                            var url = "https://www.instagram.com/bigya_dhungana/";
                            await launch(url);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                          child: const Icon(
                            FontAwesomeIcons.facebook,
                            size: 35,
                          ),
                          onPressed: ()async{
                            var url = "https://www.facebook.com/bigya.dhungana.90";
                            await launch(url);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
// ------------------------------------------SUYOG GHIMIRE-------------------------------------
            Center(
              child: Column(
                children:  <Widget> [
                  const SizedBox(
                    height: 65,
                    width: 65,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/sg.jpg'),
                      radius: 50,
                    ),
                  ),
                  const Text('Suyog Ghimire', textAlign: TextAlign.right,

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      wordSpacing: 1,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                          child: const CircleAvatar(
                            backgroundImage: AssetImage('assets/github.png'),
                            // radius: 100,
                          ),
                          onPressed: ()async{
                            var url = "https://github.com/ghimiresuyog";
                            await launch(url);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                          child: const Icon(
                            FontAwesomeIcons.linkedinIn,
                            size: 35,
                          ),
                          onPressed: ()async{
                            var url = "https://www.linkedin.com/in/suyog-ghimire-5646621a0/";
                            await launch(url);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                          child: const Icon(
                            FontAwesomeIcons.instagram,
                            size: 35,
                          ),
                          onPressed: ()async{
                            var url = "https://www.instagram.com/suyog_ghimire_/";
                            await launch(url);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                          child: const Icon(
                            FontAwesomeIcons.facebook,
                            size: 35,
                          ),
                          onPressed: ()async{
                            var url = "https://www.facebook.com/suyog.gh1";
                            await launch(url);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 30,
            ),
// ---------------------------------SHREYASH POUDEL-------------------------------------
            Center(
              child: Column(
                children:  <Widget> [
                  const SizedBox(
                    height: 65,
                    width: 65,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/sp.jpg'),
                      radius: 50,
                    ),
                  ),
                  const Text('Shreyash Poudel', textAlign: TextAlign.right,

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      wordSpacing: 1,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                          child: const CircleAvatar(
                            backgroundImage: AssetImage('assets/github.png'),
                            // radius: 100,
                          ),
                          onPressed: ()async{
                            var url = "https://github.com/ShreyashPoudel";
                            await launch(url);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                          child: const Icon(
                            FontAwesomeIcons.linkedinIn,
                            size: 35,
                          ),
                          onPressed: ()async{
                            var url = "https://www.linkedin.com/in/shreyash-poudel-784072235/";
                            await launch(url);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                          child: const Icon(
                            FontAwesomeIcons.instagram,
                            size: 35,
                          ),
                          onPressed: ()async{
                            var url = "https://www.instagram.com/poudel_shreyash/";
                            await launch(url);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                          child: const Icon(
                            FontAwesomeIcons.facebook,
                            size: 35,
                          ),
                          onPressed: ()async{
                            var url = "https://www.facebook.com/shreyash.poudel/";
                            await launch(url);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
       // ------------------------------------------- END---------------------------------------------------------
            const SizedBox(
              height: 30,
            ),
            Divider(
              height: 50,
              color: Colors.grey[500],
            ),

            Center(
              child: Column(
                children:  <Widget>[
                  ElevatedButton(onPressed: (){
                    showAboutDialog(context: context,
                    applicationName: "SadakVision",
                    applicationVersion: "v0.1",
                    applicationLegalese: "Created as third semester project for BSc. Computer Science at Kathmandu University",
                    applicationIcon: const Image(image: AssetImage('assets/SadakVision_logo.png'),
                    height: 100));
                  }, child: const Text("See more info"))
                ],
              ),
            ),

            const SizedBox(
              height: 150,
            ),

          ],
        ),
      ),
    );

  }
}
