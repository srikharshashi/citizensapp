part of 'fetch_cases_cubit.dart';

@immutable
abstract class FetchCasesState {}

class FetchCasesInitial extends FetchCasesState {}

class FetchCasesLoad extends FetchCasesState {}

class FetchCasesDone extends FetchCasesState {
  List<dynamic> cases;
  FetchCasesDone({required this.cases});
}

class FetchCaseError extends FetchCasesState {}
