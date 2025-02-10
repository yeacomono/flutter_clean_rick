import 'package:bloc/bloc.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/episode_entity.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/usecase/episode/get_episodes.dart';
import 'package:equatable/equatable.dart';

part 'episode_event.dart';
part 'episode_state.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final GetEpisodesUC getEpisodesUC;
  EpisodeBloc({required this.getEpisodesUC}) : super(EpisodeInitial()) {
    on<EpisodeEvent>((event, emit) {});
    on<AllEpisodes>(allEpisodesEvent);
    on<FindEpisode>(finEpisode);
  }
  Future<void> allEpisodesEvent(AllEpisodes event, Emitter emit) async {
    emit(EpisodeLoading());
    final request = await getEpisodesUC.call(event.page ?? 1);
    request.fold(
      (left) {
        emit(EpisodeError(left.message));
      },
      (rigth) {
        emit(EpisodeLoaded(rigth));
      },
    );
  }

  Future<void> finEpisode(FindEpisode event, Emitter emit) async {}
}
