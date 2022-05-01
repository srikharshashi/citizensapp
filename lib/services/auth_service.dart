import 'dart:convert';
import 'dart:io';

import "package:http/http.dart " as http;
import 'package:citizensapp/env.dart';
import 'package:citizensapp/services/exceptions.dart';

class AuthService {
  Future<dynamic> login(String username, String password) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(SERVER_URL + "/login"),
          headers: {'X-API-Key': API_KEY, 'Content-Type': 'application/json'},
          body: jsonEncode({"user": username, "password": password}));
      responseJson = _returnresponse_login(response);
    } on SocketException {
      throw InternetError("No internet Connection");
    }
    return responseJson;
  }

  Future<dynamic> changeETH(String jwt, String newaddress) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(SERVER_URL + "/change-wallet"),
          headers: {
            'X-API-Key': API_KEY,
            'Content-Type': 'application/json',
            'x-access-token': jwt
          },
          body: jsonEncode({"new_addr": newaddress}));
      responseJson = _returnresponse_changeETH(response);
      return responseJson;
    } on SocketException {
      throw InternetError("No internet Connection");
    }
  }

  Future<dynamic> signup(String username, String password, String ETH) async {
    var responseJson;
    print("${username} ${password} ${ETH}");
    try {
      final response = await http.post(Uri.parse(SERVER_URL + "/signup"),
          headers: {'X-API-Key': API_KEY, 'Content-Type': 'application/json'},
          body: jsonEncode(
              {"user": username, "password": password, "wallet_addr": ETH}));
      print(response.body);
      responseJson = _returnresponse_signup(response);
      return responseJson;
    } on SocketException {
      throw InternetError("No internet Connection");
    }
  }

  _returnresponse_changeETH(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          var responseJson = json.decode(response.body.toString());
          print(responseJson);
          return responseJson;
        }

      default:
        {
          print(response.statusCode);
          throw ServerError("server error ");
        }
    }
  }

  _returnresponse_login(http.Response response) {
    switch (response.statusCode) {
      case 400:
        throw APIKeyError(response.body);
      case 401:
        {
          Map<String, dynamic> responseJson =
              jsonDecode(response.body.toString());
          print(responseJson.keys);
          if (!responseJson["user_exists"])
            throw UserNotFoundError("user not found");
          else if (responseJson["message"] == "Incorrect Password")
            throw PasswordError("Incorrect Password");
          else
            throw ServerError("Server Error");
        }
      case 200:
        {
          //sucess
          var responseJson = json.decode(response.body.toString());
          print(responseJson);
          return responseJson;
        }
      default:
        {
          throw ServerError("Server Error");
        }
    }
  }

  _returnresponse_signup(http.Response response) {
    switch (response.statusCode) {
      case 201:
        {
          var responseJson = json.decode(response.body.toString());
          print(responseJson);
          return responseJson;
        }
      case 409:
        throw UserAlreadyExistsError("Username already exists");
      case 400:
        throw APIKeyError("random error");
      default:
        throw ServerError("Server Error");
    }
  }
}
