import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

Future<String> getDeviceId(BuildContext context) async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }
}