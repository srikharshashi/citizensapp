part of 'final_report_cubit.dart';

@immutable
abstract class FinalReportState {}

class FinalReportInitial extends FinalReportState {}

class FinalReportLoad extends FinalReportState {}

class FinalReportSuccess extends FinalReportState {}

class FinalReportError extends FinalReportState {
  String criminals;
  String victims;
  Map<String, String> files;
  String crimetype;
  String description;
  Position position;

  FinalReportError(
      {required this.crimetype,
      required this.criminals,
      required this.description,
      required this.files,
      required this.position,
      required this.victims});
}
