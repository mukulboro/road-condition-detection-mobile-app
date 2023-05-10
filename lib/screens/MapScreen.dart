import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class ServerData {
  final double lat;
  final double long;
  final String img;

  const ServerData({
    required this.lat,
    required this.long,
    required this.img,
  });

  factory ServerData.fromJson(Map<String, dynamic> json) {
    return ServerData(
      lat: json['longitude'],
      long: json['latitude'],
      img: json['image_name'],
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final ValueNotifier<String> _testTitle = ValueNotifier<String>("Ghyampo");
  bool isOpen = false;

  Future<bool> isLocationAvailable() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
    return true;
  }

  bool _locationAvailability = false;

  _MapScreenState() {
    isLocationAvailable().then((value) => setState(() {
          _locationAvailability = value;
        }));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void markerOnTap(int index) {
      _testTitle.value = "$index";
    }

    void openWindow() {
      setState(() {
        isOpen = true;
      });
    }

    Future<List> httpCall() async {
      List<Marker> markers = [];
      String baseUrl = "http://192.168.18.13:8000";
      var url = Uri.parse(
          "$baseUrl/nearby_road_coordinates?longitude=27.616380&latitude=85.540321");
      http.Response response = await http.get(url);
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        ServerData sd = ServerData.fromJson(list[0]);
        Marker newMarker = Marker(
            markerId: MarkerId('$i'),
            position: LatLng(sd.lat, sd.long),
            onTap: () {
              markerOnTap(i);
              openWindow();
            });
        markers.add(newMarker);
      }
      return markers;
    }

    return FutureBuilder(
        future: httpCall(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<Marker> markerList = List<Marker>.from(snapshot.data);
            return Scaffold(
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      isOpen
                          ? ValueListenableBuilder<String>(
                              valueListenable: _testTitle,
                              builder:
                                  (BuildContext context, title, Widget? child) {
                                return SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(title),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isOpen = false;
                                            });
                                          },
                                          icon: const Icon(Icons.cancel))
                                    ],
                                  )),
                                );
                              })
                          : const Text(""),
                      SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height - 100,
                          child: !_locationAvailability
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                          "Please give permission to use location"),
                                      ElevatedButton(
                                        child: const Text("Get Permission"),
                                        onPressed: () async {
                                          LocationPermission permission;
                                          permission = await Geolocator
                                              .requestPermission();
                                          if (permission ==
                                                  LocationPermission.denied ||
                                              permission ==
                                                  LocationPermission
                                                      .deniedForever) {
                                            setState(() {
                                              _locationAvailability = false;
                                            });
                                          } else {
                                            setState(() {
                                              _locationAvailability = true;
                                            });
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                )
                              : Stack(
                                  children: <Widget>[
                                    GoogleMap(
                                      initialCameraPosition:
                                          const CameraPosition(
                                              target: LatLng(27.6221, 85.54281),
                                              zoom: 15),
                                      markers: Set<Marker>.of(markerList),
                                      myLocationButtonEnabled: true,
                                      myLocationEnabled: true,
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        _controller.complete(controller);
                                      },
                                    ),
                                  ],
                                )),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
