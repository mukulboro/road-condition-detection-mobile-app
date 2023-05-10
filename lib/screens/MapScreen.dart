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
  final String user;
  final String date;
  final int cracks;
  final int potholes;
  final int rating;

  const ServerData({
    required this.lat,
    required this.long,
    required this.img,
    required this.user,
    required this.date,
    required this.cracks,
    required this.potholes,
    required this.rating,
  });

  factory ServerData.fromJson(Map<String, dynamic> json) {
    return ServerData(
        lat: json['longitude'],
        long: json['latitude'],
        img: json['image_name'],
        user: json['posted_by'],
        date: json['uploaded_date'],
        cracks: json['no_of_cracks'],
        potholes: json["no_of_potholes"],
        rating: json['rating']);
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
    List<ServerData> serverData = [];

    void markerOnTap(int index) {
      ServerData data = serverData[index];
      String img = data.img;
      String user = data.user;
      String date = data.date;
      int ph = data.potholes;
      int crk = data.cracks;
      int rating = data.rating;
      String codedString = "$img|$user|$date|$ph|$crk";
      _testTitle.value = codedString;
    }

    void openWindow() {
      setState(() {
        isOpen = true;
      });
    }

    Future<List> httpCall() async {
      List<Marker> markers = [];
      String baseUrl = "http://20.121.229.217";
      var url = Uri.parse(
          "$baseUrl/nearby_road_coordinates?longitude=27.616380&latitude=85.540321");
      http.Response response = await http.get(url);
      var list = json.decode(response.body);
      for (int i = 0; i < list.length; i++) {
        double customMarker = BitmapDescriptor.hueRed;
        ServerData sd = ServerData.fromJson(list[i]);
        serverData.add(sd);
        if (sd.rating == 0) {
          customMarker = BitmapDescriptor.hueRed;
        }
        if (sd.rating == 1) {
          customMarker = BitmapDescriptor.hueYellow;
        }
        if (sd.rating == 2) {
          customMarker = BitmapDescriptor.hueGreen;
        }
        Marker newMarker = Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(customMarker),
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
                                List<String> params = title.split("|");
                                String imgName = params[0];
                                String userName = params[1];
                                String date = params[2];
                                String pothole = params[3];
                                String crack = params[4];
                                String imgURL =
                                    "http://20.121.229.217/view-image/$imgName";

                                return SizedBox(
                                  width: 200,
                                  height: 600,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        imgURL,
                                        height: 300,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.purpleAccent,
                                              ),
                                              Text(
                                                "Crack",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                color: Color(0xff0000FF),
                                              ),
                                              Text(
                                                "Pothole",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text("Contributed By:"),
                                          Text(userName),
                                          Text("Contributed On: $date"),
                                          Text("Number of Potholes: $pothole"),
                                          Text("Number of Cracks: $crack"),
                                        ],
                                      ),
                                      FloatingActionButton(
                                        backgroundColor: Colors.red,
                                        child: const Icon(Icons.close),
                                        onPressed: () {
                                          setState(() {
                                            isOpen = false;
                                          });
                                        },
                                      )
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
                                      mapType: MapType.hybrid,
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
