import 'package:flashlightapp/src/pages/home_page.dart';
import 'package:flutter/material.dart';

//List<CameraDescription> cameras;

//Future<void> main() async {
//  try {
//    WidgetsFlutterBinding.ensureInitialized();
//    cameras = await availableCameras();
//  } on CameraException catch (e) {
//    debugPrint('$e');
//  }

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',

      home: HomePage(),
      // CameraApp(),
      // AdvCameraPage(),
    );
  }
}
