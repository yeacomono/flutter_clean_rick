part of 'episode_bloc.dart';

sealed class EpisodeState extends Equatable {
  const EpisodeState();

  @override
  List<Object> get props => [];
}

final class EpisodeInitial extends EpisodeState {}

class EpisodeLoading extends EpisodeState {}

class EpisodeLoaded extends EpisodeState {
  final List<EpisodeEntity> episodes;
  const EpisodeLoaded(this.episodes);
}

class EpisodeError extends EpisodeState {
  final String message;
  const EpisodeError(this.message);
}
