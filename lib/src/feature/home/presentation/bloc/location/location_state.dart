part of 'location_bloc.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

final class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final List<LocationEntity> locations;
  const LocationLoaded(this.locations);
}

class LocationError extends LocationState {
  final String message;
  const LocationError(this.message);
}
