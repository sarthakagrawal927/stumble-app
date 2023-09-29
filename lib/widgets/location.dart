import 'dart:async';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

Location? location;
Timer? timer;

const int frequencyTimer = 5;

Future<bool> setupLocation() async {
  location ??= Location();
  location?.enableBackgroundMode(enable: true);

  var serviceEnabled = await location!.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location!.requestService();
    if (!serviceEnabled) {
      return false;
    }
  }

  var permissionGranted = await location!.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location!.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return false;
    }
  }
  return true;
}

class MyLocationComponent extends StatefulWidget {
  const MyLocationComponent({
    super.key,
  });

  @override
  State<MyLocationComponent> createState() => _MyLocationComponent();
}

class _MyLocationComponent extends State<MyLocationComponent> {
  @override
  void initState() {
    super.initState();
    setupLocation();
    _callActivateUser();
    // WidgetsBinding.instance.addPostFrameCallback((_) => _callActivateUser());
  }

  _callActivateUser() async {
    var locationData = await location!.getLocation();
    var bodyParams = {
      "lat": locationData.latitude,
      "lng": locationData.longitude
    };
    await activateUserApi(bodyParams);
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
/**
 * Valid longitudes are from -180 to 180 degrees.
 * Valid latitudes are from -85.05112878 to 85.05112878 degrees.
*/