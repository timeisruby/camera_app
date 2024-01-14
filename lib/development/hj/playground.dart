import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription>? cameras;

class HJPlayGround extends StatefulWidget {
  const HJPlayGround({Key? key}) : super(key: key);

  @override
  State<HJPlayGround> createState() => _HJPlayGroundState();
}

class _HJPlayGroundState extends State<HJPlayGround> {
  CameraController? controller;
  String imagePath = "";

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  // 비동기로 초기화를 수행하는 함수
  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras![0], ResolutionPreset.max);

    await controller!.initialize();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // controller가 초기화되지 않았거나 이미지 캡처 중이면 Container를 반환
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                width: 200,
                height: 200,
                child: AspectRatio(
                  aspectRatio: controller!.value.aspectRatio,
                  child: CameraPreview(controller!),
                ),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    final image = await controller!.takePicture();
                    setState(() {
                      imagePath = image.path;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("Take Photo"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
