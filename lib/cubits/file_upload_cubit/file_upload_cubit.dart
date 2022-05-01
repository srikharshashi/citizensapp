import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:citizensapp/constants.dart';
import 'package:citizensapp/models/file.dart';
import 'package:citizensapp/services/file_upload.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:fluttertoast/fluttertoast.dart';

part 'file_upload_state.dart';

class FileUploadCubit extends Cubit<FileUploadState> {
  FileUploader fileUploader;

  FileUploadCubit({required this.fileUploader}) : super(FileUploadInitial());

  List<CustomFile> files = [
    CustomFile(fileType: CustomFileType.newfile, ID: "abcd")
  ];

  showtoast(String message) {
    Fluttertoast.showToast(
      msg: message, // message
      toastLength: Toast.LENGTH_SHORT, // length
      gravity: ToastGravity.BOTTOM, // location
      timeInSecForIosWeb: 4,
    );
  }

  Future<void> fileupload(File file) async {
    var response;
    try {
      if (files.length < 4) {
        emit(FileUploadLoad());

        response = await fileUploader.FileUpload(file);
        CustomFile customFile =
            CustomFile(ID: response["file_id"], fileType: getType(file));
        print(getType(file));
        files.add(customFile);
        emit(FileUploadDone(files: files));
      } else {
        showtoast("File Limit has reached");
      }
    } catch (e) {
      print("random error");
      print(e.toString());
      emit(FileUploadError());
    }
  }

  void deletefile(int i) {
    files.removeAt(i);
    emit(FileUploadDone(files: files));
  }

  void reload() {
    files = [CustomFile(fileType: CustomFileType.newfile, ID: "abcd")];
    emit(FileUploadInitial());
  }

  CustomFileType getType(File file) {
    print(p.extension(file.path));
    switch (p.extension(file.path).toLowerCase()) {
      case ".jpeg":
      case ".jpg":
      case ".png":
        return CustomFileType.image;
      case ".mp4":
      case ".mkv":
      case ".mov":
        return CustomFileType.video;
      case ".mp3":
      case ".wav":
      case ".m4a":
        return CustomFileType.audio;
      default:
        return CustomFileType.newfile;
    }
  }

  Map<String, String> getFileList() {
    Map<String, String> mapp = {};
    files.forEach((cfile) {
      mapp.addEntries(<String, String>{
        cfile.ID: cfile.fileType.toString().split(".")[1]
      }.entries);
    });
    mapp.remove("abcd");
    print(mapp);
    return mapp;
  }
}
