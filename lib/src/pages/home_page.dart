import 'package:flashlightapp/src/pages/adv_camera_page.dart';
import 'package:flashlightapp/src/pages/lantern_page.dart';
import 'package:flashlightapp/src/widgets/privacy_policy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';

class HomePage extends StatelessWidget {
  Future<void> _displayDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return PrivacyPolicy();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text('Zoom Lantern'),
      ),
      drawer: Drawer(
        child: Container(
          child: Column(
            children: <Widget>[
              SafeArea(
                child: Container(
                  child: Image(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/flashlightmagnifier.jpg'),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.blueAccent,
                ),
                enabled: true,
                title: Text(
                  'Home',
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.share,
                  color: Colors.blueAccent,
                ),
                title: Text(
                  'Share',
                ),
                onTap: () {
                  Share.share(
                      'Lantern App https://play.google.com/store/apps/details?id=com.mundodiferente.flashlightapp');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.library_books,
                  color: Colors.blueAccent,
                ),
                title: Text(
                  'Pivacy Policy',
                ),
                onTap: () {
                  Navigator.pop(context);
                  _displayDialog(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.blueAccent,
                ),
                title: Text(
                  'Exit',
                ),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            top: 30.0,
            bottom: 50.0,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => AdvCameraPage(),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 30.0,
                    ),
                    height: 300.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        24.0,
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/magnifier.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.5),
                        backgroundBlendMode: BlendMode.darken,
                        borderRadius: BorderRadius.circular(
                          24.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Magnifier & Lantern ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => LanternPage(),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'lantern',
                    transitionOnUserGestures: true,
                    child: Material(
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: 30.0,
                        ),
                        height: 300.0,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            24.0,
                          ),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/torch.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.5),
                            backgroundBlendMode: BlendMode.darken,
                            borderRadius: BorderRadius.circular(
                              24.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Only Lantern',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
