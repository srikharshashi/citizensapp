part of 'file_upload_cubit.dart';

@immutable
abstract class FileUploadState {}

class FileUploadInitial extends FileUploadState {}

class FileUploadLoad extends FileUploadState {}

class FileUploadDone extends FileUploadState {
  List<CustomFile> files;
  FileUploadDone({required this.files});
}

class FileUploadError extends FileUploadState {}

class FileLimitExceeded extends FileUploadState{}