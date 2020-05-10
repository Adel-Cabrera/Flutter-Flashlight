import 'dart:io';

import 'package:adv_camera/adv_camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';

class AdvCameraPage extends StatefulWidget {
  @override
  _AdvCameraPageState createState() => _AdvCameraPageState();
}

class _AdvCameraPageState extends State<AdvCameraPage> {
  List<String> pictureSizes = [];
  String imagePath;

  File _image;

  PermissionStatus _status;

  bool freezedImage = false;
  double _value = 1.01;

  bool setFlash = false;

  @override
  initState() {
    super.initState();
    _askPermission();
  }

  void _updateStatus(PermissionStatus status) {
    if (status != _status) {
      setState(
        () {
          _status = status;
        },
      );
    }
  }

  void _askPermission() {
    PermissionHandler().requestPermissions([
      PermissionGroup.camera,
      PermissionGroup.storage
    ]).then(_onStatusRequested);
  }

  PermissionStatus statusStorage;
  PermissionStatus statusCamera;

  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses) {
    statusStorage = statuses[PermissionGroup.storage];
    if (statusStorage != PermissionStatus.granted) {
      PermissionHandler().openAppSettings();
    } else {
      _updateStatus(statusStorage);
    }
    statusCamera = statuses[PermissionGroup.camera];
    if (statusCamera != PermissionStatus.granted) {
      PermissionHandler().openAppSettings();
    } else {
      _updateStatus(statusCamera);
    }
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO show snackbar of options for lantern and torch
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Magnifier and Lantern'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
//                SingleChildScrollView(
//                  scrollDirection: Axis.horizontal,
//                  child: Container(
//                    color: Colors.purple,
//                    child: Row(
//                      children: [
//                        FlatButton(
//                          child: Text("Auto"),
//                          onPressed: () {
//                            cameraController.setFlashType(FlashType.auto);
//                          },
//                        ),
//                        FlatButton(
//                          child: Text("On"),
//                          onPressed: () {
//                            cameraController.setFlashType(FlashType.on);
//                          },
//                        ),
//                        FlatButton(
//                          child: Text("Off"),
//                          onPressed: () {
//                            cameraController.setFlashType(FlashType.off);
//                          },
//                        ),
//                        FlatButton(
//                          child: Text("Torch"),
//                          onPressed: () {
//                            cameraController.setFlashType(FlashType.torch);
//                          },
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//                SingleChildScrollView(
//                  scrollDirection: Axis.horizontal,
//                  child: Container(
//                    color: Colors.orange,
//                    child: Row(
//                      children: [
//                        FlatButton(
//                          child: Text(Platform.isAndroid ? "1:1" : "Low"),
//                          onPressed: () {
//                            cameraController
//                                .setPreviewRatio(CameraPreviewRatio.r1);
//                            cameraController
//                                .setSessionPreset(CameraSessionPreset.low);
//                          },
//                        ),
//                        FlatButton(
//                          child: Text(Platform.isAndroid ? "4:3" : "Medium"),
//                          onPressed: () {
//                            cameraController
//                                .setPreviewRatio(CameraPreviewRatio.r4_3);
//                            cameraController
//                                .setSessionPreset(CameraSessionPreset.medium);
//                          },
//                        ),
//                        FlatButton(
//                          child: Text(Platform.isAndroid ? "11:9" : "High"),
//                          onPressed: () {
//                            cameraController
//                                .setPreviewRatio(CameraPreviewRatio.r11_9);
//                            cameraController
//                                .setSessionPreset(CameraSessionPreset.high);
//                          },
//                        ),
//                        FlatButton(
//                          child: Text(Platform.isAndroid ? "16:9" : "Best"),
//                          onPressed: () {
//                            cameraController
//                                .setPreviewRatio(CameraPreviewRatio.r16_9);
//                            cameraController
//                                .setSessionPreset(CameraSessionPreset.photo);
//                          },
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//                SingleChildScrollView(
//                  scrollDirection: Axis.horizontal,
//                  child: Container(
//                    color: Colors.blue,
//                    child: Row(
//                      children: this.pictureSizes.map(
//                        (pictureSize) {
//                          return FlatButton(
//                            child: Text(pictureSize),
//                            onPressed: () {
//                              cameraController.setPictureSize(
//                                int.tryParse(
//                                  pictureSize.substring(
//                                    0,
//                                    pictureSize.indexOf(":"),
//                                  ),
//                                ),
//                                int.tryParse(
//                                  pictureSize.substring(
//                                      pictureSize.indexOf(":") + 1,
//                                      pictureSize.length),
//                                ),
//                              );
//                            },
//                          );
//                        },
//                      ).toList(),
//                    ),
//                  ),
//                ),
                Expanded(
                  child: freezedImage == false
                      ? Container(
                          child: (statusStorage == PermissionStatus.granted &&
                                  statusCamera == PermissionStatus.granted)
                              ? GestureDetector(
                                  onScaleUpdate: (value) {
                                    _value = value.scale;
                                  },
                                  child: Transform.scale(
                                    scale: _value,
                                    child: AdvCamera(
                                      onCameraCreated: _onCameraCreated,
                                      onImageCaptured: (String path) {
                                        setState(
                                          () {
                                            imagePath = path;
                                            freezedImage = !freezedImage;
                                          },
                                        );
                                      },
                                      cameraPreviewRatio:
                                          CameraPreviewRatio.r16_9,
                                    ),
                                  ),
                                )
                              : Container(),
                        )
                      // TODO add pinch to zoom explanation
                      : Container(
                          child: PhotoView(
                            imageProvider: FileImage(
                              File(imagePath),
                            ),
                          ),
                        ),
                ),
              ],
            ),
            (freezedImage == false)
                ? Positioned(
                    left: 0,
                    top: MediaQuery.of(context).size.height * 0.2,
                    child: Container(
                      height: 300.0,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Slider(
                          min: 1,
                          max: 15,
                          value: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                          },
                        ),
                      ),
                    ),
                  )
                : Container(),
// **************** IMAGE FROM THE LEFT BOTTOM CORNER
//            Positioned(
//              bottom: 16.0,
//              left: 16.0,
//              child: imagePath != null
//                  ? Container(
//                      width: 100.0,
//                      height: 100.0,
//                      child: Image.file(
//                        File(imagePath),
//                      ),
//                    )
//                  : Icon(Icons.image),
//            )
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          (freezedImage == false)
              ? FloatingActionButton(
                  heroTag: '5',
                  child: Icon(Icons.switch_camera),
                  onPressed: () {
                    cameraController.switchCamera();
                  },
                )
              : Container(),
          SizedBox(
            height: 10.0,
          ),
          (freezedImage == false)
              ? FloatingActionButton(
                  heroTag: '0',
                  child: Icon(Icons.lightbulb_outline),
                  onPressed: () {
                    cameraController.setFlashType(FlashType.torch);
                  },
                )
              : Container(),
          SizedBox(
            height: 10.0,
          ),
          (freezedImage == false)
              ? FloatingActionButton(
                  heroTag: '1',
                  child: setFlash != true
                      ? Icon(Icons.flash_on)
                      : Icon(Icons.flash_off),
                  onPressed: () {
                    if (setFlash == true) {
                      setFlash = !setFlash;
                      cameraController.setFlashType(FlashType.on);
                    } else {
                      setFlash = !setFlash;
                      cameraController.setFlashType(FlashType.off);
                    }

                    setState(() {});

                    print('***************************************');
                    print('Flash is $setFlash');
                    print('***************************************');
                  },
                )
              : Container(),
          SizedBox(
            height: 10.0,
          ),
          (freezedImage == false)
              ? FloatingActionButton(
                  heroTag: '2',
                  child: Icon(Icons.camera),
                  onPressed: () {
                    cameraController.captureImage();
                  },
                )
              : Container(),
          (freezedImage != false)
              ? FloatingActionButton(
                  heroTag: '3',
                  child: Icon(Icons.refresh),
                  onPressed: () {
                    freezedImage = !freezedImage;
                    setState(() {});
//              getImageFromGallery();
                  },
                )
              : Container(),
        ],
      ),
    );
  }

  AdvCameraController cameraController;

  _onCameraCreated(AdvCameraController controller) {
    this.cameraController = controller;

    this.cameraController.getPictureSizes().then(
      (pictureSizes) {
        setState(
          () {
            this.pictureSizes = pictureSizes;
          },
        );
      },
    );
  }
}
