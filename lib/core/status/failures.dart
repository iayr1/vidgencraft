abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure([String message = 'Server error occurred']) : super(message);
}

class ConnectionFailure extends Failure {
  ConnectionFailure([String message = 'No internet connection']) : super(message);
}

class TimeoutFailure extends Failure {
  TimeoutFailure([String message = 'Request timed out']) : super(message);
}

class GeneralFailure extends Failure {
  GeneralFailure([String message = 'An unexpected error occurred']) : super(message);
}