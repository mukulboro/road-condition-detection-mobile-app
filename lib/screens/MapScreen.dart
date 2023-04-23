import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}


class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kDhulikhel =  CameraPosition
    (target: LatLng(27.6221, 85.54281,),
    zoom: 14.4746,
  );

 final List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(27.6221, 85.54281,),
        infoWindow: InfoWindow(
          snippet: "Testing",
          title: 'My Home',
        )
    ),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(27.6196887444591, 85.54034192606396),
        infoWindow: InfoWindow(
            title: 'Kathmandu University'
        )
    ),
  ];

  @override
  void initState(){
    super.initState();
    _marker.addAll(_list);
  }


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
                SizedBox(width: double.infinity, height: 730,
                child: GoogleMap(initialCameraPosition: _kDhulikhel,
                  // markers: Set<Marker>.of(_marker),
                  // onMapCreated: (GoogleMapController controller){
                  // _controller.complete(controller);
                  // },
                ),
                )


              ],

          ),
      ),
    );
  }
}
