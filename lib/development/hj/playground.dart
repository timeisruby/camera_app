import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class HJPlayGround extends StatefulWidget {
  const HJPlayGround({Key? key}) : super(key: key);

  @override
  State<HJPlayGround> createState() => _HJPlayGroundState();
}

class _HJPlayGroundState extends State<HJPlayGround> {
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    List<CameraDescription> cameras = await availableCameras();

    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await _cameraController.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(title: Text("HJ - 카메라 화면")),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("HJ - 카메라 화면")),
      body: CameraPreview(_cameraController),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
