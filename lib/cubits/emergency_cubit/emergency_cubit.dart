import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:citizenapp2/env.dart';
import 'package:citizenapp2/services/location_service.dart';
import 'package:meta/meta.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
part 'emergency_state.dart';

class EmergencyCubit extends Cubit<EmergencyState> {
  LocationService locationService;
  EmergencyCubit({required this.locationService}) : super(EmergencyInitial());
  final box = Hive.box("main");
  void emergency() async {
    String jwt = box.get("jwt");
    Position position;
    try {
      emit(EmergencyLoad());
      Position position = await locationService.getlatloc();
      try {
        var URL = Uri.parse(SERVER_URL + "/emergency");
        var response = await http.post(URL,
            headers: {
              'X-API-Key': API_KEY,
              'Content-Type': 'application/json',
              'x-access-token': jwt
            },
            body: jsonEncode({
              "location": [position.longitude, position.latitude]
            }));
        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 201) {
          emit(EmergencySucess());
        } else {
          emit(EmergencyError());
        }
      } catch (e) {
        emit(EmergencyError());
      }
    } catch (e) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        LocationPermission p2 = await Geolocator.requestPermission();
        emit(EmergencyError());
      }
    }
  }
}
