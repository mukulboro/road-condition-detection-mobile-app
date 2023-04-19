import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}


class _MapScreenState extends State<MapScreen> {
  // TODO: Add Google Maps Widget
  // TODO: Ask for location permission
  // TODO: Send Screen to current location
  // TODO: Plot Dummy Data in Map
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget> [
            Text("Map Screen edited by shreyash", textAlign: TextAlign.left,),
            Text("Map Screen edited by dddd", textAlign: TextAlign.left,)
          ],
        ),
      ),
    );
  }
}
