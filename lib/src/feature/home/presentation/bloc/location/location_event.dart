part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class AllLocation extends LocationEvent {
  final int? page;
  const AllLocation({this.page});
  @override
  List<Object> get props => [page ?? 1];
}

class FindLocation extends LocationEvent {
  final int id;
  const FindLocation(this.id);
  @override
  List<Object> get props => [id];
}

class FilterLocation extends LocationEvent {
  @override
  List<Object> get props => [];
}
