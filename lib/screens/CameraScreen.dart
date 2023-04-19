import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  // TODO: Add Camera Widget
  // TODO: Get user permission for camera
  // TODO: Get Storage Access
  // TODO: Click and store image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget> [
            Text("Camera Screen edited"),
            Text("hello mukul boro how is life going on?")
          ],
        ),
      ),
    );
  }
}
