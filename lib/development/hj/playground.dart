import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class HJPlayGround extends StatefulWidget {
  final List<CameraDescription> cameras;
  const HJPlayGround({Key? key, required this.cameras}) : super(key: key);
  @override
  State<HJPlayGround> createState() => _HJPlayGroundState();
}

class _HJPlayGroundState extends State<HJPlayGround> {
  late List<CameraDescription> cameras = [];
  late CameraController cameraController;
  late Future<void> cameraValue;

  int direction = 0;

  @override
  void initState() {
    super.initState();

    if (widget.cameras.isNotEmpty) {
      startCamera(direction);
    }
  }

  void startCamera(int direction) async {
    try {
      cameraController =
          CameraController(widget.cameras[direction], ResolutionPreset.high);
      await cameraController.initialize();
      setState(() {});
    } catch (e) {
      print("Failed to initialize camera: $e");
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized) {
      return Scaffold(
        body: Stack(
          children: [
            CameraPreview(cameraController),
            GestureDetector(
              onTap: () {
                setState(() {
                  direction = direction == 0 ? 1 : 0;
                  startCamera(direction);
                });
              },
              child:
                  button(Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
            ),
            GestureDetector(
              onTap: () {
                cameraController.takePicture().then((XFile? file) {
                  if (mounted) {
                    if (file != null) {
                      print("Picture saved to ${file.path}");
                    }
                  }
                });
              },
              child: button(Icons.camera_alt_outlined, Alignment.bottomCenter),
            ),
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: Text(
                "My Camera",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget button(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
