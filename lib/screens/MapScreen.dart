import 'dart:async';
import 'dart:collection';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocode/geocode.dart';
//import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:path/path.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';
import 'package:uuid/uuid.dart';
import 'package:custom_info_window/custom_info_window.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}


class _MapScreenState extends State<MapScreen> {

Completer<GoogleMapController> _controller = Completer();
List<Marker> markers = [];
int id = 1;
Set<Polyline> _polylines = Set<Polyline>();
List<LatLng> polylineCoordinates = [];

CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  bool isOpen = false;

  Future<bool> isLocationAvailable() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
    return true;
  }

  // final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kDhulikhel = CameraPosition
    (target: LatLng(27.6221, 85.54281,),
    zoom: 14.4746,
  );
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
  }


  @override
  Widget build(BuildContext context) {
    void markerOnTap() {
      setState(() {
        isOpen = !isOpen;
      });
    }

    final List<Marker> _marker = <Marker>[];
    final List<Marker> _list = [
      Marker(
          markerId: const MarkerId('2'),
          position: const LatLng(27.6196887444591, 85.54034192606396),
          onTap: () {
            markerOnTap();
          }
      ),
      Marker(
        markerId: const MarkerId('3'),
        position: const LatLng(27.616380, 85.540321),
        onTap: () {
          // print('Taped');
          markerOnTap();
        },
      ),
    ];


    _list.add(Marker(
        markerId: const MarkerId('1'),
        position: const LatLng(27.6221, 85.54281,),
        onTap: () {
          // print(LatLng(27.6221, 85.54281,),);
          markerOnTap();
        }
    ),);

    _marker.addAll(_list);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{

        },
        child: Icon(Icons.refresh_rounded,),
      ),
      body: SingleChildScrollView(
        child: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              isOpen ? const SizedBox(
                width: 200,
                height: 200,
                child: Text("randi ko chak"),
              ) : const Text(""),

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
                      initialCameraPosition: const CameraPosition(
                          target: LatLng(27.6221, 85.54281),
                          zoom: 15
                      ),

                      markers: Set<Marker>.of(_marker),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      myLocationEnabled: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}


