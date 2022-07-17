import 'package:bloc/bloc.dart';
import 'package:citizenapp2/services/location_service.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required this.locationService}) : super(LocationInitial());
  LocationService locationService;

  void getLocation() async {
    emit(LocationLoad());
    try {
      Position position = await locationService.getlatloc();
      emit(LocationGot(position: position));
      print(position.latitude + position.longitude);
    } catch (e) {
      print(e.toString());
      emit(LocationError(message: e.toString()));
    }
  }

  void reload() {
    emit(LocationInitial());
  }
}
