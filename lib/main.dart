import 'package:camera/camera.dart';
import 'package:camera_app/development/hj/playground.dart';
import 'package:camera_app/development/hj/locator.dart';
import 'package:camera_app/development/sw/playground.dart';
import 'package:camera_app/screen/camera_screen.dart';
import 'package:camera_app/screen/main_screen.dart';
import 'package:flutter/material.dart';

// 개발은 공동으로 진행될 예정이고, 상세 기능 분리가 아직 되지는 않아서 우선은 master 브랜치에서 작업 진행
// 폴더 구조가 명확히 구분되면 그때 브랜치를 따로 파서 작업 진행

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MyApp({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Picture",
      initialRoute: "/",
      routes: {
        '/': (context) => HomeScreen(), // 이동 화면
        '/sw': (context) => SWPlayGround(), // 개발 화면
        '/hj': (context) => HJPlayGround(cameras: cameras), // 개발 화면
        // 추후 프러턱트 주소가 -> '/' 변경 예정
        '/product': (context) => CameraScreen(), // 실제 프러덕트 화면
      },
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  setupLocator();
  runApp(MyApp(cameras: cameras));
}
