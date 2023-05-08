import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;


  // TODO: Add Camera Widget
  // TODO: Get user permission for camera
  // TODO: Get Storage Access
  // TODO: Click and store image

  @override
  void initState(){
    startCamera(0);
    //getPermissionStatus();
    super.initState();
  }
  void startCamera(int direction ) async{
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }

      setState(() {});
    }).catchError((e){
      print(e);
    });
  }
  @override
  void dispose(){
    cameraController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized){
      return Scaffold(
        body: Stack(
          children: [
            CameraPreview(cameraController),
            // GestureDetector(
            //     onTap: (){
            //         setState((){
            //           direction=direction == 0 ? 1 : 0;
            //           startCamera(direction);
            //         });
            //
            //   },
            //     child: button(Icons.flip_camera_android_sharp, Alignment.bottomCenter)
            // ),
            GestureDetector(
              onTap: (){
                cameraController.takePicture().then((XFile? file) {
                  if(mounted){
                    if (file!=null){
                      print("Picture saved to ${file.path}");
                    }
                  }
                });
              },
              child:button(Icons.camera_alt_outlined, Alignment.bottomCenter),
            ),

            // Align(
            //   alignment:AlignmentDirectional.topCenter,
            //   child: Text(
            //     "CAMERA ",
            //     style: TextStyle(
            //       fontSize: 20,
            //       color: Colors.red,
            //     ),
            //   ),
            // )

          ],
        ),

      );
    }else{
      return const SizedBox();
    }
  }
  Widget button(IconData icon , Alignment alignment){
    return Align(
      alignment: alignment,
      child: Container(
        margin: EdgeInsets.only(
          left: 10,
          bottom: 45,
        ),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.deepPurple,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2,2),
                blurRadius: 10,
              )
            ]
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
