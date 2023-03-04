import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {}

Future<Position> getCurrentPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error("Location service are disabled");
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("location permision are denied 2");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error("location permision are denied forever");
  }
  Position position = await Geolocator.getCurrentPosition();
  return position;
}

class PrintPosition extends StatefulWidget {
  const PrintPosition({super.key});

  @override
  State<PrintPosition> createState() => PrintPostion();
}

class PrintPostion extends State<PrintPosition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () async {
          var postion = await getCurrentPosition();
          print(postion.latitude);
        },
        child: const Text("Get Location"),
      )),
    );
  }
}
