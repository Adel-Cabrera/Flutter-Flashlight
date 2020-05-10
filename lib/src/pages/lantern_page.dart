import 'dart:async';
import 'package:flashlightapp/src/providers/change_slider_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_torch/flutter_torch.dart';
import 'package:provider/provider.dart';

class LanternPage extends StatefulWidget {
  @override
  _LanternPageState createState() => _LanternPageState();
}

class _LanternPageState extends State<LanternPage> {
  bool isLanternOn = false;
  bool _hasTorch = false;
  Timer timer;
  int _value = 51;
  bool startParty = false;
  bool onlyOneInstance = true;
  bool activatePulses = false;

  @override
  void initState() {
    super.initState();
    initTorchState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initTorchState() async {
    bool hasTorch = false;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      hasTorch = await FlutterTorch.hasLamp;
    } on PlatformException {
      hasTorch = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _hasTorch = hasTorch;
    });
  }

  @override
  Widget build(BuildContext context) {
    void doParty() {
      if (!startParty) {
        timer?.cancel();
      } else {
        timer = Timer.periodic(
          Duration(milliseconds: _value),
          (Timer _) {
            FlutterTorch.turnOn();
            FlutterTorch.turnOff();
            setState(() {});
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text('Lantern'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(
            0.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  (isLanternOn == false)
                      ? 'Click to activate'
                      : 'Click to deactivate',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Hero(
                  tag: 'lantern',
                  child: GestureDetector(
                    onTap: () {
                      if (!isLanternOn) {
                        timer?.cancel();
                        startParty = false;
//                        onlyOneInstance = false;
                        activatePulses = false;
                        FlutterTorch.turnOn();
                      } else {
                        timer?.cancel();
//                        onlyOneInstance = true;
                        activatePulses = false;
                        FlutterTorch.turnOff();
                      }
                      onlyOneInstance = true;

                      isLanternOn = !isLanternOn;

                      setState(() {});
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24.0),
                        child: Image(
                          image: AssetImage(
                            'assets/images/torch.jpg',
                          ),
                          color: (!isLanternOn) ? Colors.black54 : Colors.white,
                          colorBlendMode: BlendMode.overlay,
                          fit: BoxFit.cover,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 3.0,
                            blurRadius: 10.0,
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Icon(
                  !isLanternOn ? Icons.flash_off : Icons.flash_on,
                  size: 100.0,
                  color: Colors.blueAccent,
                ),
              ),
              RaisedButton(
                onPressed: () {
                  activatePulses = true;

                  if (onlyOneInstance && activatePulses) {
                    startParty = true;
                    doParty();
                  }
                  isLanternOn = false;
                  onlyOneInstance = false;
                  activatePulses = false;

                  FlutterTorch.turnOff();
                  setState(() {});
                },
                child: Text('Activate pulses'),
              ),
              RaisedButton(
                onPressed: () {
                  startParty = false;
                  timer?.cancel();
                  onlyOneInstance = true;
                  isLanternOn = false;
                  FlutterTorch.turnOff();

                  setState(() {});
                },
                child: Text('Deactivate pulses'),
              ),
              Slider(
                activeColor:
                    (startParty == true) ? Colors.blueAccent : Colors.blueGrey,
                min: 50,
                max: 1000,
                value: _value.toDouble(),
                onChanged: (value) {
                  if (startParty == true) {
                    setState(() {
                      startParty = false;
                      timer?.cancel();
                      _value = value.toInt();
                      Provider.of<ChangeSliderValue>(context, listen: false)
                          .currentValue = value.toInt();
                      startParty = true;
                      doParty();

                      print(_value);
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
