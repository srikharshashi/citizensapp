import 'package:citizensapp/cubits/file_upload_cubit/file_upload_cubit.dart';
import 'package:citizensapp/models/file.dart';
import 'package:citizensapp/ui/widgets/fileicon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomFileUpload extends StatefulWidget {
  List<CustomFile> files;
  CustomFileUpload({Key? key, required this.files}) : super(key: key);

  @override
  State<CustomFileUpload> createState() => _CustomFileUploadState();
}

class _CustomFileUploadState extends State<CustomFileUpload> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      height: 100,
      width: 800,
      child: ListView.builder(
        itemCount: widget.files.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return FileIcon(
            showdel: true,
            fileType: widget.files[index].fileType,
            onDelete: () {
              context.read<FileUploadCubit>().deletefile(index);
            },
          );
        },
      ),
    );
  }
}
