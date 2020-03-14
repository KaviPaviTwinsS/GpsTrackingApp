import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterlocationupdate/UserLocation.dart';
import 'package:location/location.dart';

class LocationService {
  UserLocation _currentLocation;
  var location = Location();

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
    return _currentLocation;
  }


  StreamController<UserLocation> _locationController =
  StreamController<UserLocation>();

  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    // Request permission to use location
    location.requestPermission().then((granted) {
      print('Location data granted $granted');
      if (granted != null) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        location.onLocationChanged().listen((locationData) {
          if (locationData != null) {
            print('Location data $locationData');
//            insertLocation(locationData);
            _locationController.add(UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
            ));
          }
        });
      }
    });
  }
  final databaseReference = Firestore.instance;

  void insertLocation(LocationData locationData) async {
    DocumentReference ref = await databaseReference.collection(
        "deviceLocationUpdate").add(
        {'lattitude': locationData.latitude, 'longtitude': locationData.longitude});
    print('Document ID ${ref.documentID}');
  }
}