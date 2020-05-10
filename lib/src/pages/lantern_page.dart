//TODO add flutter_torch package or alike

import 'package:flutter/material.dart';

class LanternPage extends StatefulWidget {
  @override
  _LanternPageState createState() => _LanternPageState();
}

class _LanternPageState extends State<LanternPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text('Lantern'),
      ),
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}
