import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udevs_tz/src/core/resourses/data_state.dart';
import 'package:udevs_tz/src/features/data/repository/get_location_repository.dart';

import '../../../data/models/location/location.dart';

part 'get_location_event.dart';
part 'get_location_state.dart';

class GetLocationBloc extends Bloc<GetLocationEvent, GetLocationState> {
  final GetLocationRepository _getLocationRepository;
  GetLocationBloc(this._getLocationRepository) : super(GetLocationInitial()) {
    on<GetCurrentLocationEvent>(onGetCurrentLocationEvent);
  }

  void onGetCurrentLocationEvent(
      GetCurrentLocationEvent event, Emitter<GetLocationState> emit) async {
    emit(GetLocationLoading());
    DataSate dataState = await _getLocationRepository.getLocation(
        lat: event.lat, lon: event.lon);

    if (dataState is DataSuccess) {
      emit(GetLocationSuccess(CurrentLocation.fromJson(dataState.data)));
    } else if (dataState is DataFailure) {
      emit(
        GetLocationFailure(
            dataState.dioException?.errorMessage['errorMessage'] ?? 'error'),
      );
    }
  }
}
