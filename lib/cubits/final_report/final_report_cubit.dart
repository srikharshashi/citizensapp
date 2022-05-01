import 'package:bloc/bloc.dart';
import 'package:citizensapp/services/data_calls.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'final_report_state.dart';

class FinalReportCubit extends Cubit<FinalReportState> {
  DataCall dataCall;
  var box = Hive.box("main");

  FinalReportCubit({required this.dataCall}) : super(FinalReportInitial());

  void reportCase(String criminals, String victims, Map<String, String> files,
      String crimetype, String description, Position position) async {
    emit(FinalReportLoad());
    String jwt = box.get("jwt");

    bool result = await dataCall.reportCase(
        jwt, criminals, victims, files, crimetype, description, position);
    if (result) {
      emit(FinalReportSuccess());
    } else {
      emit(FinalReportError(
        victims: victims,
        position: position,
        crimetype: crimetype,
        files: files,
        description: description,
        criminals: criminals,
      ));
    }
  }
}
