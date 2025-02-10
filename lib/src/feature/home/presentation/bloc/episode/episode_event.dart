part of 'episode_bloc.dart';

sealed class EpisodeEvent extends Equatable {
  const EpisodeEvent();

  @override
  List<Object> get props => [];
}

class AllEpisodes extends EpisodeEvent {
  final int? page;
  const AllEpisodes({this.page});
  @override
  List<Object> get props => [page ?? 1];
}

class FindEpisode extends EpisodeEvent {
  final int id;
  const FindEpisode(this.id);
  @override
  List<Object> get props => [id];
}

class FilterEpisode extends EpisodeEvent {
  @override
  List<Object> get props => [];
}
