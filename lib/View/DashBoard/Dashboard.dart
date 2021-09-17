import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vhical_finder/Controller/DemoController.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vhical_finder/View/SigninSignUp/login.dart';
import 'package:vhical_finder/util/constant.dart';

class Dashbord extends StatefulWidget {
  @override
  _DashbordState createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  var demoController = Get.put(DemoController());
  final GoogleSignIn googleSignIn = GoogleSignIn();
  SharedPreferences? prefs;
  String? id;
  late List<Marker> markers = [];
  late Timer timer;
  late Position latlong;
  var lat = 23.5415763;
  var lan = 87.3055799;
  var i = 1;
  bool isLoading = false;
  MapController mapController = MapController();

  late List<Marker> demo_markers = [
    Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(19.5415763, 87.3055799),
      builder: (ctx) => Container(
        child: Icon(
          Icons.pin_drop_sharp,
          color: red,
        ),
      ),
    )
  ];

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    myLocation();
    super.initState();
  }

  myLocation() async {
    latlong = await determinePosition();
    lat = latlong.latitude;
    lan = latlong.longitude;
    // await getLocation();

    markers.add(Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(lat, lan),
      builder: (ctx) => Container(
        child: Icon(
          Icons.pin_drop_sharp,
          color: red,
        ),
      ),
    ));
  }

  // getStream()async{
  //   await determinePosition();
  //   Geolocator.getPositionStream().listen((Position position) async{
  //     print(position);
  //     await getLocation();
  //     print(i++);
  //   });
  // }

  getLocation() async {
    timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      prefs = await SharedPreferences.getInstance();
      id = prefs?.getString('id') ?? '';
      latlong = await Geolocator.getCurrentPosition();
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update({'lat': latlong.latitude, 'lan': latlong.longitude});
      setState(() {});
    });
  }

  Future<Null> handleSignOut() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    setState(() {
      isLoading = false;
    });

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        timer.cancel();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('MParivhan'),
            actions: [
              InkWell(
                  onTap: () async {
                    await handleSignOut();
                  },
                  child: Icon(Icons.logout))
            ],
          ),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                )
              : StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      markers.clear();
                      var doc = snapshot.data!.docs;
                      for (var users in doc) {
                        // print(LatLng(users['lat'], users['lan']));
                        markers.add(Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(users['lat'], users['lan']),
                          builder: (ctx) => Container(
                            child: Icon(
                              Icons.pin_drop_sharp,
                              color: red,
                            ),
                          ),
                        ));
                      }
                      // print('userList ${markers.length}');
                      return Column(
                        children: [
                          Expanded(
                            child: FlutterMap(
                              mapController: mapController,
                              options: MapOptions(
                                  center: LatLng(lat, lan),
                                  zoom: 13.0,
                                  onTap: (latLn) {
                                    print('latLn');
                                    print(latLn);
                                    demo_markers.assign(Marker(
                                      width: 80.0,
                                      height: 80.0,
                                      point: latLn,
                                      builder: (ctx) => Container(
                                        child: Icon(
                                          Icons.pin_drop_sharp,
                                          color: Colors.pink,
                                        ),
                                      ),
                                    ));
                                    setState(() {
                                    });
                                  }),
                              layers: [
                                TileLayerOptions(
                                    urlTemplate:
                                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                    subdomains: ['a', 'b', 'c']),
                                MarkerLayerOptions(
                                  markers: demo_markers,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                      );
                    }
                  })),
    );
  }
}
