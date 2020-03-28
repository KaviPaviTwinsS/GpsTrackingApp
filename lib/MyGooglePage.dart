import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterlocationupdate/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyGoogleMapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyGoogleMapPageState();
  }
}

class MyGoogleMapPageState extends State<MyGoogleMapPage> {
  static const double CAMERA_ZOOM = 8;
  static int UPDATION = 8;

  LatLng _center = new LatLng(45.521563, -122.677433);
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  BitmapDescriptor sourceIcon;
  List<LatLng> polygonPoints = new List<LatLng> ();
  List<Marker> markerssss = new List<Marker> ();

  LatLng _markerPosition = new LatLng(0.0,0.0);


  String tappedMarkerPosition ='';

  double zoomValue = 10.0;

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/location.png');
  }


  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

   /*
    _markers.add(Marker(
      draggable: true,
        markerId: MarkerId('sourcePin'),
        position: _center,
        icon: sourceIcon
    ));*/
   _markers.add(
       Marker(
           onTap: () {
             print('Tapped');
           },
           draggable: true,
           markerId: MarkerId('Marker'),
           position: LatLng(_center.latitude, _center.longitude),
           onDragEnd: ((_centres) {
             print(_centres.latitude);
             print(_centres.longitude);
           }))
   );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('My Google Map'),),
       /* body: Container(
//            child :Column(
//          children: <Widget>[
          child: GoogleMap(
           *//* myLocationEnabled: true,
            myLocationButtonEnabled: true,
            rotateGesturesEnabled : true,
            scrollGesturesEnabled : true,
            zoomGesturesEnabled: true,
            tiltGesturesEnabled: false,*//*
            onMapCreated: _onMapCreated,
            markers: _markers,
           *//* markers: Set<Marker>.of(
              <Marker>[
                Marker(
                  draggable: true,
                  markerId: MarkerId("1"),
                  position: _center,
                  icon: BitmapDescriptor.defaultMarker,
                  infoWindow: const InfoWindow(
                    title: 'Usted está aquí',
                  ),
                )
              ],
            ),
            onCameraMove: ((_position) => _updatePosition(_position)),*//*
            polygons: _polygons,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: CAMERA_ZOOM,
            ),
            onTap: _handleTap,
            onCameraMove:(CameraPosition cameraPosition){
            print('cameraPosition ${cameraPosition.zoom}');
          },
          ),
          *//* RaisedButton(onPressed: (){

            },
            child: Text('Tap to draw polygon'),)*//*
//          ],
//        )
        )*/

      body: Stack(
        children: <Widget>[

          Container(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: zoomValue,
              ),
              onMapCreated: _onMapCreated,
              markers: _markers,
              polygons: _polygons,
//              onCameraMove: ((_position) => _updatePosition(_position)),
              onTap: _handleTap,
            ),
          ),
          zoomMinusFunction(),

          zoomPlusFunction(),
          Container(
            child: Align(
              alignment: Alignment.topCenter,
              child: IconButton(icon: Icon(FontAwesomeIcons.discord,color: themeColor,), onPressed: (){
               setState(() {
                 _markers.clear();
                 _polygons.clear();
                 polygonPoints.clear();
               });
              }),
            ),
          )

        ],
      ),
    );
  }
  Widget zoomMinusFunction(){
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(icon: Icon(FontAwesomeIcons.searchMinus,color: themeColor,), onPressed: (){
        zoomValue -- ;
        zoomMinus(zoomValue);
      }),
    );
  }

  Widget zoomPlusFunction(){
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(icon: Icon(FontAwesomeIcons.searchPlus,color: themeColor,), onPressed: (){
        zoomValue ++ ;
        zoomMinus(zoomValue);
      }),
    );
  }

  Future zoomMinus(double zoomValue) async{
    final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _center,zoom: zoomValue)));
  }
/*

  void _updatePosition(LatLng _position) {
    LatLng newMarkerPosition = LatLng(
         _position.latitude,
         _position.longitude);
    Marker marker = markers["1"];

    setState(() {
      markers["1"] = marker.copyWith(
          positionParam: LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
    });
  }
*/




  _handleTap(LatLng point) {
    tappedMarkerPosition =  'Marker ${UPDATION--}';
    print('POINT $point');
    setState(() {
      polygonPoints.add(point);
      _markerPosition = point;
    });
    print('polygonPoints ${polygonPoints.length}');
    if (polygonPoints.length > 2) {
      _polygons.add(Polygon(
        polygonId: PolygonId('Polygon ${UPDATION--}'),
        points: polygonPoints,
        strokeColor: Colors.blue,
        strokeWidth: 10,
        fillColor: Colors.blue.withOpacity(0.1),
      ));
    }
    Marker ss;
    ss =Marker(
      draggable: true,
      onDragEnd: (value){
        setState(() {
          print('onDragEnd $value _____${ss.position} _____ ${ss.markerId.value} ');
          for(int i=0 ;i<polygonPoints.length;i++){
            if(ss.position == polygonPoints[i]){
              print('onDragEnd_markerPosition $_markerPosition _____${polygonPoints[i]} ');
              polygonPoints[i] = value;
            }
          }
      /*    for(int i=0 ;i<markerssss.length;i++){
            if(_markerPosition == msss[i].position){
//              print('onDragEnd_markerssss ${markerssss[i].markerId.value} _____${markerssss[i].position} ');
              polygonPoints[i] = value;
            }
            print('onDragEnd_markerssss ${markerssss[i].markerId.value} _____${markerssss[i].position} ');

          }*/
          setState(() {
//              polygonPoints.add(value);
              _markerPosition = value;
          });
        });
      },
      consumeTapEvents: true,
      onTap: (){

        print('Tapped ${ss.markerId.value}');
        setState(() {
          _markers.remove(ss.markerId.value);
        });
      },
      markerId: MarkerId(tappedMarkerPosition),
      position: _markerPosition,
      infoWindow: InfoWindow(
        title: 'I am a marker',
      ),
      icon:
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
    );
    _markers.add(ss);
    markerssss.add(ss);
  }
}