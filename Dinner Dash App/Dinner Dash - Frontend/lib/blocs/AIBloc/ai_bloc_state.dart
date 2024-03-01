import 'package:equatable/equatable.dart';

/*abstract class AIState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AIInitial extends AIState {}

class AIImageRecognitionSuccess extends AIState {
  final List<dynamic> recognitionResults;

  AIImageRecognitionSuccess({required this.recognitionResults});

  @override
  List<Object?> get props => [recognitionResults];
}

class AIError extends AIState {
  final String message;

  AIError({required this.message});

  @override
  List<Object?> get props => [message];
}

////////////////////////////////
abstract class AIState {}

class AIInitial extends AIState {}

class AIImageRecognitionSuccess extends AIState {
  final List<dynamic> recognitionResults;

  AIImageRecognitionSuccess({required this.recognitionResults});
}

class AIError extends AIState {
  final String message;

  AIError({required this.message});
}*/


import 'package:equatable/equatable.dart';

abstract class AIState extends Equatable {
  @override
  List<Object> get props => [];
}

class AIInitial extends AIState {}

class AIImageRecognitionSuccess extends AIState {
  final List<dynamic> recognitionResults;

  AIImageRecognitionSuccess({required this.recognitionResults});

  @override
  List<Object> get props => [recognitionResults];
}

class AIError extends AIState {
  final String message;

  AIError({required this.message});

  @override
  List<Object> get props => [message];
}
