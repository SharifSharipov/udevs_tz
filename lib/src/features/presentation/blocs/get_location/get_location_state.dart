part of 'get_location_bloc.dart';

sealed class GetLocationState extends Equatable {
  const GetLocationState();

  @override
  List<Object> get props => [];
}

final class GetLocationInitial extends GetLocationState {}

final class GetLocationLoading extends GetLocationState {}

final class GetLocationSuccess extends GetLocationState {
  final CurrentLocation currentLocation;
  const GetLocationSuccess(this.currentLocation);
  @override
  List<Object> get props => [
        currentLocation,
      ];
}

final class GetLocationFailure extends GetLocationState {
  final String errorMessage;
  const GetLocationFailure(this.errorMessage);
  @override
  List<Object> get props => [
        errorMessage,
      ];
}
