import 'package:bloc/bloc.dart';
import 'package:citizensapp/constants.dart';
import 'package:citizensapp/models/question.dart';
import 'package:meta/meta.dart';

import 'package:geolocator/geolocator.dart';
part 'add_case_state.dart';

class AddCaseCubit extends Cubit<AddCaseState> {
  AddCaseCubit() : super(AddCaseInitial());

  void step1done(String desc, String classif, Position position) {
    emit(AddCase1Done(
        crimeType: classif, description: desc, position: position));
  }

  void step2done(
      String criminals,
      String victims,
      Map<String,String> files,
      String crimetype,
      String description,
      Position position) {
    emit(AddCase2Done(
        crimeType: crimetype,
        description: description,
        criminals: criminals,
        position: position,
        files: files,
        victims: victims));
  }



  void step3done(
      String criminals,
      String victims,
      Map<String, String> files,
      String crimetype,
      String description,
      Position position) {
    emit(AddCase3Done(
        crimeType: crimetype,
        description: description,
        criminals: criminals,
        position: position,
        files: files,
        victims: victims));

  }

  void reload() {
    emit(AddCaseInitial());
  }

  

  List<Question> getQuestion(String crimetype) {
    switch (crimetype) {
      case "Theft":
        return theftquestion;
      case "Sexual Harrashment":
        return sexharrsahquestion;
      case "Homicide":
        return homicidequestion;
      case "Terrorism":
        return terrorismquestion;
      case "Animal Abuse":
        return animalabusequestion;
      case "Corruption":
        return corruptionquestion;
      case "Child Abuse":
        return childabusequestion;
      case "Domestic Violence":
        return domvioquestion;
      default:
        return defaultques;
    }
  }
}
