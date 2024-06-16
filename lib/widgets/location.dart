import 'dart:async';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/constants_fonts.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

class MyLocationComponent extends StatefulWidget {
  const MyLocationComponent({
    super.key,
  });

  @override
  State<MyLocationComponent> createState() => _MyLocationComponent();
}

class _MyLocationComponent extends State<MyLocationComponent> {
  bool isLocationWorking = true;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _callActivateUser();
    });
  }

  _callActivateUser() async {
    try {
      var locationData = await determinePosition();
      var bodyParams = {
        "lat": locationData.latitude,
        "lng": locationData.longitude
      };
      await activateUserApi(bodyParams);
    } catch (e) {
      setState(() {
        isLocationWorking = false;
      });
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isLocationWorking) {
      return Center(
        child: Container(
          padding: EdgeInsets.all(marginHeight128(context)),
          margin: EdgeInsets.all(marginHeight8(context)),
          color: Colors.red,
          child: Text(
            textAlign: TextAlign.left,
            'Oops! Stumble can\'t accurately function without your location! :(',
            style:
                TextStyle(color: Colors.white, fontSize: fontSize48(context)),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
/**
 * Valid longitudes are from -180 to 180 degrees.
 * Valid latitudes are from -85.05112878 to 85.05112878 degrees.
*/
