part of 'get_location_bloc.dart';

sealed class GetLocationEvent extends Equatable {
  const GetLocationEvent();

  @override
  List<Object> get props => [];
}

final class GetCurrentLocationEvent extends GetLocationEvent {
  final double lat;
  final double lon;
  const GetCurrentLocationEvent({
    required this.lat,
    required this.lon,
  });
  @override
  List<Object> get props => [lat, lon];
}
