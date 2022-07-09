part of 'add_case_cubit.dart';

//base state 
@immutable
abstract class AddCaseState {}

class AddCaseInitial extends AddCaseState {}

class AddCase1Done extends AddCaseState {
  String crimeType;
  String description;
  Position position;
  AddCase1Done(
      {required this.crimeType,
      required this.description,
      required this.position});
}

class AddCase2Done extends AddCaseState {
  String crimeType;
  String description;
  Position position;
  String criminals;
  String victims;
  Map<String, String> files;
  AddCase2Done(
      {required this.crimeType,
      required this.description,
      required this.criminals,
      required this.position,
      required this.files,
      required this.victims});
}


class AddCase3Done extends AddCaseState
{
  String crimeType;
  String description;
  Position position;
  String criminals;
  String victims;
  Map<String, String> files;
  AddCase3Done(
      {required this.crimeType,
      required this.description,
      required this.criminals,
      required this.position,
      required this.files,
      required this.victims});
}

