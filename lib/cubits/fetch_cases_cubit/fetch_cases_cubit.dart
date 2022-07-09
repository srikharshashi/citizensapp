import 'package:bloc/bloc.dart';
import 'package:citizenapp2/services/data_calls.dart';
import 'package:meta/meta.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'fetch_cases_state.dart';

class FetchCasesCubit extends Cubit<FetchCasesState> {
  final box = Hive.box("main");

  DataCall dataCall;
  FetchCasesCubit({required this.dataCall}) : super(FetchCasesInitial());

  void getCases() async {
    String jwt = box.get("jwt");
    emit(FetchCasesLoad());
    try {
      final response = await dataCall.getCases(jwt);
      List<dynamic> cases =
          response["cases"].reversed.map((e) => e.toString()).toList();
      print(cases);
      emit(FetchCasesDone(cases: cases));
    } catch (e) {
      print(e);
      emit(FetchCaseError());
    }
  }
}
