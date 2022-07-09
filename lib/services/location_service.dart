import 'dart:io';

import 'package:citizenapp2/services/exceptions.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getlatloc() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position;
    } on SocketException {
      throw InternetError("Internet Error");
    }
  }
}
