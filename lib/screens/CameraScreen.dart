//CAMERA SCREEN BY SUYOG GHIMIRE **____**

import 'dart:async';
import 'dart:io';
import 'dart:io' as Io;
import 'dart:convert';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key,
    required this.camera,
    this.credentials
  });

  final Credentials? credentials;
  final CameraDescription camera;

  @override
  State<CameraScreen> createState() => _CameraScreenState(credentials: credentials);
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final Credentials? credentials;

  _CameraScreenState({this.credentials});


  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: (16 / 9) * (MediaQuery.of(context).size.width),
                child: CameraPreview(_controller));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: SizedBox(
        height: 100,
        width: 5000,
        child: FloatingActionButton(
          onPressed: () async {
            try {
              await _initializeControllerFuture;
              final image = await _controller.takePicture();
              if (!mounted) return;
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(
                    imagePath: image.path,
                    credentials: credentials,
                  ),
                ),
              );
            } catch (e) {
              print(e);
            }
          },
          child: const Icon(
            Icons.camera_alt_outlined,
            size: 60,
          ),
        ),
      ),
    );
  }
}

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final Credentials? credentials;
  const DisplayPictureScreen({super.key, required this.imagePath, this.credentials});


  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState(credentials: credentials);
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  final Credentials? credentials;
  _DisplayPictureScreenState({this.credentials});

  @override
  Widget build(BuildContext context) {


    Future<bool> _handleLocationPermission() async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location services are disabled. Please enable the services')));
        return false;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permissions are denied')));
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location permissions are permanently denied, we cannot request permissions.')));
        return false;
      }
      return true;
    }


    Future<Position> getCurrentPosition() async {
      final hasPermission = await _handleLocationPermission();
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;
    }


    Future<http.Response> httpCall(double latitude,double longitude,String username, String image_string) {
      return http.post(
        Uri.parse('http://192.168.18.13:8000/post'),
        headers: {"Content-Type":"application/json"},
        body: json.encode({
          'longitude': longitude,
          'latitude': latitude,

          'username': username,
          'image_string': image_string,
        }),
      );
    }

    return FutureBuilder(
      future: getCurrentPosition(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(!snapshot.hasData){
          return const Center(child: CircularProgressIndicator());
        }else{
          Position position = snapshot.data;

        return Scaffold(
            appBar: AppBar(title: const Text('Send image to process?')),
            body: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.file(File(widget.imagePath)),
                    const SizedBox(
                      width: double.infinity,
                      height: 30,
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pinkAccent,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 25,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'No Thanks',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            onPressed: () {
                              final bytes = Io.File(widget.imagePath).readAsBytesSync();
                              String img64 = base64Encode(bytes);
                              String userEmail = credentials?.user.email ?? "err";
                              httpCall(position.longitude, position.latitude, userEmail,img64 );

                              const snackBar = SnackBar(
                                content: Text('Your Image Has Been Sent to Server'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              Navigator.pop(context);

                            },
                            icon: const Icon(
                              Icons.done,
                              size: 25,
                              color: Colors.white,
                            ),
                            label: const Text('Yes Sure',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                          width: 20,
                        ),
                      ],
                    ),
                  ]),
            ));}
      }
    );
  }
}
