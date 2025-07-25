import 'package:equatable/equatable.dart';
import 'package:movie_app/core/error/exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final String statusCode;

  const Failure({required this.message, required this.statusCode});

  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object> get props => [message, statusCode];
}

//This is for exception messages and status code when api fails

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException exception)
    : this(message: exception.message, statusCode: exception.statusCode);
}

class APIFailure extends Failure {
  const APIFailure({required super.message, required super.statusCode});

  APIFailure.fromException(APIException exception)
    : this(message: exception.message, statusCode: exception.statusCode);
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.statusCode});
}
