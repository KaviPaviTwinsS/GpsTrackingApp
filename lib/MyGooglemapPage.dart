import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import 'UserLocation.dart';


class MyGoogleMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return myGoogleMapState();
  }
}

class myGoogleMapState extends State<MyGoogleMap> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng _center = new LatLng(45.521563, -122.677433);
  GoogleMapController mapController;
  final databaseReference = Firestore.instance;


  Set<Marker> _markers = Set<Marker>();
  BitmapDescriptor sourceIcon;

  static const double CAMERA_ZOOM = 11;
  static const double CAMERA_TILT = 80;
  static const double CAMERA_BEARING = 30;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    mapController = controller;
    setState(() {
      _markers.removeWhere(
              (m) => m.markerId.value == 'sourcePin');
      // add the initial source location pin
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: _center,
          icon: sourceIcon
      ));
    });
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/location.png');
  }

@override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
//    var userLocation = Provider.of<UserLocation>(context);
//    _center = new LatLng(userLocation.latitude, userLocation.longitude);
    getData();
    updatePinOnMap();
    return Scaffold(
        appBar: AppBar(title: Text('My Google Map'),),
        body: GoogleMap(
          myLocationEnabled: true,
//              markers: Set<Marker>.of(markers.values), // YOUR MARKS IN MAP
          markers: _markers,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: CAMERA_ZOOM,
          ),
        )
    );
  }

  void updatePinOnMap() async {

    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
//      tilt: CAMERA_TILT,
//      bearing: CAMERA_BEARING,
      target: LatLng(_center.latitude,
          _center.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      var pinPosition = LatLng(_center.latitude,
          _center.longitude);

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere(
              (m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: pinPosition, // updated position
          icon: sourceIcon
      ));
    });
  }


  void getData() {
/*
    print('getData');
    databaseReference
        .collection("deviceLocationUpdate")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) =>
      {
        _center = new LatLng(f.data['lattitude'], f.data['longtitude']),
      });
      updatePinOnMap();
    });
*/

    databaseReference.collection("deviceLocationUpdate").snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        // Do something with change
        _center = new LatLng(change.document.data['lattitude'], change.document.data['longtitude']);
        print('changess $_center');
      });
    });
//    databaseReference.collection("").document("-M29QJyD_vrRT1p4_4qa").set()
  }

}