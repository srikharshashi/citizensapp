import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:citizensapp/env.dart';
import './exceptions.dart';

class FileUploader {
  Future<dynamic> FileUpload(File file) async {
    try {
      var request = http.MultipartRequest(
          "POST", Uri.parse(FILE_UPLOAD_SERVER + "/upload"));
      //create multipart using filepath, string or bytes
      var pic = await http.MultipartFile.fromPath("filee", file.path);
      //add multipart to request
      request.files.add(pic);
      var response = await request.send();

      //Get the response from the server
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var responseJson = _returnresponse(response.statusCode, responseString);
      return responseJson;
    } on SocketException {
      throw InternetError("Internet Error");
    }
  }

  _returnresponse(int statusCode, String body) {
    switch (statusCode) {
      case 511:
        throw APIKeyError("API key error");
      case 401:
        throw ServerError("Server Error");
      case 200:
        {
          //sucess
          var responseJson = jsonDecode(body);
          print(responseJson);
          return responseJson;
        }
      default:
        throw ServerError("Server Error");
    }
  }

  // Future<dynamic> FileUpload(File file) async {
  //   Future.delayed(
  //     Duration(seconds: 4),
  //   );
  //   return {
  //     "file_id": "abcd",
  //   };
  // }
}
