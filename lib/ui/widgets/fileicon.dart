import 'package:citizenapp2/constants.dart';
import 'package:citizenapp2/cubits/file_upload_cubit/file_upload_cubit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../../cubits/theme_cubit/theme_cubit.dart';

class FileIcon extends StatefulWidget {
  CustomFileType fileType;
  VoidCallback onDelete;
  bool showdel;
  FileIcon(
      {Key? key,
      required this.fileType,
      required this.onDelete,
      required this.showdel})
      : super(key: key);

  @override
  State<FileIcon> createState() => _FileIconState();
}

class _FileIconState extends State<FileIcon> {
  @override
  Widget build(BuildContext context) {
    print(widget.fileType.toString());
    switch (widget.fileType) {
      case CustomFileType.audio:
        {
          return Container(
            height: 100,
            width: 100,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                widget.showdel
                    ? Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: widget.onDelete,
                          child: Icon(
                            FontAwesomeIcons.trashCan,
                            size: 16,
                          ),
                        ),
                      )
                    : Text(""),
                Container(
                  height: 15,
                ),
                Icon(
                  FontAwesomeIcons.music,
                ),
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(
              color: context.read<ThemeCubit>().gettheme() == "Light"
                  ? Colors.black
                  : Colors.white,
            )),
          );
        }
      case CustomFileType.image:
        {
          return Container(
            height: 100,
            width: 100,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                widget.showdel
                    ? Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: widget.onDelete,
                          child: Icon(
                            FontAwesomeIcons.trashCan,
                            size: 16,
                          ),
                        ),
                      )
                    : Text(""),
                Container(
                  height: 15,
                ),
                Center(
                    // alignment: Alignment.center,
                    child: Icon(FontAwesomeIcons.image)),
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(
                    color: context.read<ThemeCubit>().gettheme() == "Light"
                        ? Colors.black
                        : Colors.white)),
          );
        }
      case CustomFileType.newfile:
        {
          return GestureDetector(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: [
                  'jpg',
                  'jpeg',
                  'png',
                  'mp4',
                  'mkv',
                  'mov',
                  'mp3',
                  'wav',
                  'm4a'
                ],
              );
              if (result != null) {
                File file = File(result.files.single.path!);
                BlocProvider.of<FileUploadCubit>(context).fileupload(file);
              }
            },
            child: Container(
              height: 100,
              width: 100,
              child: Icon(FontAwesomeIcons.plus),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: context.read<ThemeCubit>().gettheme() == "Light"
                          ? Colors.black
                          : Colors.white)),
            ),
          );
        }
      case CustomFileType.video:
        {
          return Container(
            height: 100,
            width: 100,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                widget.showdel
                    ? Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: widget.onDelete,
                          child: Icon(
                            FontAwesomeIcons.trashCan,
                            size: 16,
                          ),
                        ),
                      )
                    : Text(""),
                Container(
                  height: 15,
                ),
                Center(
                  // alignment: Alignment.center,
                  child: Icon(FontAwesomeIcons.video),
                ),
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(
                    color: context.read<ThemeCubit>().gettheme() == "Light"
                        ? Colors.black
                        : Colors.white)),
          );
        }
      default:
        {
          return Container();
        }
    }
  }
}
