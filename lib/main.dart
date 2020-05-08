import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(new CameraApp());
}

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => new _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController cameraController;

  double scale = 1.0;

  @override
  void initState() {
    super.initState();

    cameraController = new CameraController(cameras[0], ResolutionPreset.high);

    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return new Container();
    }

    var cameraPreview = new CameraPreview(cameraController);

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Builder(
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: new GestureDetector(
                  onScaleUpdate: (one) {
                    print(one.scale);

                    scale = one.scale;
                    setState(() {});
                  },
                  child: new Transform.scale(
                    scale: scale,
                    child: new AspectRatio(
                        aspectRatio: cameraController.value.aspectRatio,
                        child: cameraPreview),
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.refresh,
              ),
            ),
            FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.remove,
              ),
            ),
            FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.add,
              ),
            )
          ],
        ),
      ),
    );
  }
}

//import 'package:flutter/material.dart';
//import 'dart:async';
//
//import 'package:flutter/services.dart';
//import 'package:flutter_torch/flutter_torch.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatefulWidget {
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> {
//  bool _hasTorch = false;
//
//  @override
//  void initState() {
//    super.initState();
//    initTorchState();
//  }
//
//  // Platform messages are asynchronous, so we initialize in an async method.
//  Future<void> initTorchState() async {
//    bool hasTorch = false;
//    // Platform messages may fail, so we use a try/catch PlatformException.
//    try {
//      hasTorch = await FlutterTorch.hasLamp;
//    } on PlatformException {
//      hasTorch = false;
//    }
//
//    // If the widget was removed from the tree while the asynchronous platform
//    // message was in flight, we want to discard the reply rather than calling
//    // setState to update our non-existent appearance.
//    if (!mounted) return;
//
//    setState(() {
//      _hasTorch = hasTorch;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
//        appBar: AppBar(
//          title: const Text('Plugin example app'),
//        ),
//        body: Center(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              Text('Has torch: $_hasTorch\n'),
//              RaisedButton(
//                onPressed: () {
//                  FlutterTorch.turnOn();
//                },
//                child: Text('Turn On'),
//              ),
//              RaisedButton(
//                onPressed: () {
//                  FlutterTorch.turnOff();
//                },
//                child: Text('Turn Off'),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
