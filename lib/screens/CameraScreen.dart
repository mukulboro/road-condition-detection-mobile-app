//CAMERA SCREEN BY SUYOG GHIMIRE **____**

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
  void initState(){
    super.initState();
    _controller=CameraController(widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture=_controller.initialize();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat ,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context,snapshot){
          if (snapshot.connectionState==ConnectionState.done){
            return SizedBox(
              width: MediaQuery. of(context). size. width,
                height: (16/9)*(MediaQuery. of(context). size. width),
                child: CameraPreview(_controller));
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: SizedBox(
        height:100,
        width:5000,

        child: FloatingActionButton(
          onPressed: () async{
            try {
              await _initializeControllerFuture;
              final image = await _controller.takePicture();
              if (!mounted) return;
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      DisplayPictureScreen(
                        imagePath: image.path,
                      ),
                ),
              );
            }catch (e){
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

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SEND IMAGE TO PROCESS?')),
      body: Center(
        child: Column(
          children: [
            Image.file(File(imagePath)
            ),
        Row(
            children: <Widget> [
              Expanded(child: ElevatedButton.icon(
                  onPressed:(
                      ){
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 25,
                  ), label: Text('NO')
        ),
              ),
              Expanded(child: ElevatedButton.icon(
                onPressed:(){},
                icon: Icon(
                Icons.done,
                size: 25,
                      ),
                  label: Text('YES')
              ),
              )
            ],
        ),
        ]
        ),

    )
    );
  }
}




