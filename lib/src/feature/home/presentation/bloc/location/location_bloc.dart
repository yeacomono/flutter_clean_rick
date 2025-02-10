import 'package:bloc/bloc.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/location_entity.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/usecase/location/get_locations.dart';
import 'package:equatable/equatable.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetLocationsUC getLocationsUC;

  LocationBloc({required this.getLocationsUC}) : super(LocationInitial()) {
    on<LocationEvent>((event, emit) {});
    // on<LocationEvent>();
    on<AllLocation>(allEpisodesEvent);
    on<FindLocation>(finEpisode);
  }
  Future<void> allEpisodesEvent(AllLocation event, Emitter emit) async {
    emit(LocationLoading());
    final request = await getLocationsUC.call(event.page ?? 1);
    request.fold(
      (left) {
        emit(LocationError(left.message));
      },
      (rigth) {
        emit(LocationLoaded(rigth));
      },
    );
  }

  Future<void> finEpisode(FindLocation event, Emitter emit) async {}
}
