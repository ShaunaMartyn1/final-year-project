import 'package:equatable/equatable.dart';

/*abstract class AIEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PerformImageRecognitionEvent extends AIEvent {
  final String imagePath;

  PerformImageRecognitionEvent({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}


abstract class AIEvent {}

class PerformImageRecognitionEvent extends AIEvent {
  final String imagePath;

  PerformImageRecognitionEvent({required this.imagePath});
}*/


abstract class AIEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PerformImageRecognitionEvent extends AIEvent {
  final String imagePath;

  PerformImageRecognitionEvent({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}
