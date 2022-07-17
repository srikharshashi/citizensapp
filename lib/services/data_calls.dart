import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:citizenapp2/env.dart';
import 'package:citizenapp2/models/case.dart';
import 'package:citizenapp2/services/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class DataCall {
  Future<bool> reportCase(
      String jwt,
      String criminals,
      String victims,
      Map<String, String> files,
      String crimetype,
      String description,
      Position position) async {
    print(criminals);
    print(victims);
    print(files);
    print(crimetype);
    print(description);
    print(position);
    var response;
    try {
      var response = await http.post(Uri.parse(SERVER_URL + "/new-report"),
          headers: {
            'X-API-Key': API_KEY,
            'Content-Type': 'application/json',
            'x-access-token': jwt
          },
          body: jsonEncode({
            "desc": description,
            "victims": victims,
            "ofenders": criminals,
            "location": [position.longitude, position.latitude],
            "time": DateTime.now().toString(),
            "classified_ByUser": crimetype,
            "files": files
          }));
      var decodedres = jsonDecode(response.body);
      if (decodedres["uploaded"] == "success") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<dynamic> getCases(String jwt) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(SERVER_URL + "/get-reports"),
          headers: {
            'X-API-Key': API_KEY,
            'Content-Type': 'application/json',
            'x-access-token': jwt
          });
      responseJson = _returnrespose(response);
      return responseJson;
    } on SocketException {
      throw InternetError("Internet Error");
    }
  }

  _returnrespose(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          var responseJson = json.decode(response.body.toString());
          print(responseJson);
          return responseJson;
        }
      default:
        throw ServerError("Server error");
    }
  }

  Future<Case> getCase(String CaseID, String jwt) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(SERVER_URL + "/get-case-info"),
          headers: {
            'X-API-Key': API_KEY,
            'Content-Type': 'application/json',
            'x-access-token': jwt
          },
          body: jsonEncode({
            "case_id": CaseID,
          }));
      responseJson = _returnrespose(response);
      return Case.fromJSON(responseJson);
    } on SocketException {
      throw InternetError("Error in internet");
    }
  }

  

}
