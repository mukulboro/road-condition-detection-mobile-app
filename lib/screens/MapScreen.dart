import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:path/path.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';
import 'package:uuid/uuid.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}


class _MapScreenState extends State<MapScreen> {

  final controllerr = TextEditingController();

  Future<bool> isLocationAvailable() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
    return true;
  }

  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kDhulikhel = CameraPosition
    (target: LatLng(27.6221, 85.54281,),
    zoom: 14.4746,
  );

  final List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(27.6221, 85.54281,),
        infoWindow: InfoWindow(
          title: 'My Home',
        )
    ),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(27.6196887444591, 85.54034192606396),
        infoWindow: InfoWindow(title: 'Kathmandu University')
    ),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(27.616380, 85.540321),
        infoWindow: InfoWindow(title: 'Boys Home')
    )

  ];

  bool _locationAvailability = false;

  _MapScreenState() {
    isLocationAvailable().then((value) =>
        setState(() {
          _locationAvailability = value;
        }));
  }

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }


  // TODO: Ask for location permission
  // TODO: Send Screen to current location
  // TODO: Plot Dummy Data in Map

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[
            // TextField(
            //   controller: controllerr,
            //   onTap: () async{},
            //   decoration: InputDecoration(
            //     icon: Container(
            //       margin: const EdgeInsets.only(left: 20),
            //       width: 10,
            //         height: 10,
            //       child: const Icon(Icons.location_on, color: Colors.white,),
            //   ),
            //     hintText: " Search Location",
            //     border: InputBorder.none,
            //     contentPadding: const EdgeInsets.only(left: 8.0, top: 16.0)
            // ),
            // ),

            SizedBox(
              width: double.infinity,
              height: 730,
              child: !_locationAvailability ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [


                    const Text("Please give permission to use location"),
                    ElevatedButton(child: const Text("Get Permission"),
                      onPressed: () async {
                        LocationPermission permission;
                        permission = await Geolocator.requestPermission();
                        if (permission == LocationPermission.denied ||
                            permission == LocationPermission.deniedForever) {
                          setState(() {
                            _locationAvailability = false;
                          });
                        } else {
                          setState(() {
                            _locationAvailability = true;
                          });
                        }
                      },)
                  ],
                ),
              ) :

              Stack(
                children: <Widget>[
                  GoogleMap(

                    initialCameraPosition: _kDhulikhel,
                    //mapType: MapType.satellite,
                    myLocationEnabled: true,
                    markers: Set<Marker>.of(_marker),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  // Positioned(
                  //   top: 100,
                  //   left: 10,
                  //   right: 20,
                  //   child: GestureDetector(
                  //     onTap: (){},
                  //     child: Container(
                  //       height: 50,
                  //       padding: EdgeInsets.symmetric(horizontal: 5)
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
