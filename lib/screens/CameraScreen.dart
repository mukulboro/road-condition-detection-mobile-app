//CAMERA SCREEN BY SUYOG GHIMIRE **____**

import 'dart:async';
import 'dart:io';
import 'dart:io' as Io;
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;


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

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  @override
  Widget build(BuildContext context) {

    String? _currentAddress;
    Position? _currentPosition;

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
                              print('LOCATION DIYO');
                              print(position.latitude);
                              print(position.longitude);

                              final bytes = Io.File(widget.imagePath).readAsBytesSync();

                              String img64 = base64Encode(bytes);
                              print(
                                  'IMAGE HAS BEEN ENCODED TO BASE64');
                              print(img64);
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
