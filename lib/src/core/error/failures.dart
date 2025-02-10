enum FailureType { network, server, cache, unknown }

abstract class Failure {
  final FailureType type;
  final String message;

  const Failure({required this.type, this.message = "An error occurred"});
}

class ServerFailure extends Failure {
  ServerFailure({super.message = "Server error occurred"})
      : super(type: FailureType.server);
}

class CacheFailure extends Failure {
  CacheFailure({super.message = "Cache error occurred"})
      : super(type: FailureType.cache);
}

class NetworkFailure extends Failure {
  NetworkFailure({super.message = "Network error occurred"})
      : super(type: FailureType.network);
}

class UnknownFailure extends Failure {
  UnknownFailure({super.message = "Unknown error occurred"})
      : super(type: FailureType.unknown);
}
