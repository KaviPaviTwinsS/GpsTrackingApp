import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlocationupdate/LocationService.dart';
import 'package:flutterlocationupdate/MyGooglemapPage.dart';
import 'package:flutterlocationupdate/UserLocation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class MyLocationUpdatePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MyLocationUpdateState();
  }

}

class MyLocationUpdateState extends State<MyLocationUpdatePage> {



  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      builder: (context) => LocationService().locationStream,
      child: MaterialApp(
          title: 'Location update to Server',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            appBar: AppBar
              (
              title: Text('MY Location update'),
            ),
            body: MyLocationUpdate(),
          )),
    );
  }


}

class MyLocationUpdate extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    getVersionNumber();
    var userLocation = Provider.of<UserLocation>(context);
    print('userLocation build');
//    return Center
//    return Container(
//      child:
    /*  child : Row(
        children: <Widget>[
//        Text(
//          'Location: Lat${userLocation?.latitude}, Long: ${userLocation?.longitude}'),
          GoogleMap(
          onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          )
        ],
      )*/
//      child: Text(
//          'Location: Lat${userLocation?.latitude}, Long: ${userLocation?.longitude}'),


    return Column(
      children: <Widget>[
        RaisedButton(
          textColor: Colors.white,
          color: Colors.blue,
          child: Text('Google Map'),
          onPressed: () {
            navigateToSubPage(context);
          },
        ),
        Text(
            'Location: Lat${userLocation?.latitude}, Long: ${userLocation
                ?.longitude}'),
        Text('version Name  ${versionName}  Version code $versionCode')
      ],
    );
  }

  String versionCode = "";
  String versionName ="";

  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
     versionName = packageInfo.version;
     versionCode = packageInfo.buildNumber;
    // Other data you can get:
    //
    // 	String appName = packageInfo.appName;
    // 	String packageName = packageInfo.packageName;
    //	String buildNumber = packageInfo.buildNumber;
  }


  Future navigateToSubPage(context) async {
    Navigator.push(
        context,
        CupertinoPageRoute(
            fullscreenDialog: false, builder: (context) => new MyGoogleMap()));
  }


}