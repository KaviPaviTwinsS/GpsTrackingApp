import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyGoogleMapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyGoogleMapPageState();
  }
}

class MyGoogleMapPageState extends State<MyGoogleMapPage> {
  static const double CAMERA_ZOOM = 11;
  LatLng _center = new LatLng(45.521563, -122.677433);
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  BitmapDescriptor sourceIcon;
  List<LatLng> polygonPoints = new List<LatLng> ();


  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/location.png');
  }


  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: _center,
        icon: sourceIcon
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('My Google Map'),),
        body: Container(
//            child :Column(
//          children: <Widget>[
          child: GoogleMap(
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            markers: _markers,
            polygons: _polygons,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: CAMERA_ZOOM,
            ),
            onTap: _handleTap,
          ),
          /* RaisedButton(onPressed: (){

            },
            child: Text('Tap to draw polygon'),)*/
//          ],
//        )
        )
    );
  }


  _handleTap(LatLng point) {
    print('POINT $point');
    setState(() {
      polygonPoints.add(point);
      print('polygonPoints ${polygonPoints.length}');
      if (polygonPoints.length > 2) {
        _polygons.add(Polygon(
          polygonId: PolygonId(point.toString()),
          points: polygonPoints,
          strokeColor: Colors.blue,
          strokeWidth: 10,
          fillColor: Colors.blue.withOpacity(0.1),
        ));
      }
    });
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'I am a marker',
        ),
        icon:
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ));
  }
}