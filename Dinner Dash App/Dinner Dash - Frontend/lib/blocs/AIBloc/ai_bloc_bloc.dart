import 'package:bloc/bloc.dart';
import 'package:flutter_app/blocs/AIBloc/ai_bloc_event.dart';
import 'package:flutter_app/blocs/AIBloc/ai_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tflite/tflite.dart';



class AIBloc extends Bloc<AIEvent, AIState> {
  AIBloc() : super(AIInitial()) {
    on<PerformImageRecognitionEvent>(_onPerformImageRecognition);
    _loadModel();
  }

  Future<void> _loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future<void> _onPerformImageRecognition(PerformImageRecognitionEvent event, Emitter<AIState> emit) async {
    try {
      List<dynamic>? recognitionResults = await Tflite.runModelOnImage(
        path: event.imagePath,
        imageMean: 127.5,
        imageStd: 127.5,
        numResults: 5,
        threshold: 0.5,
      );

      if (recognitionResults != null) {
        emit(AIImageRecognitionSuccess(recognitionResults: recognitionResults));
      } else {
        emit(AIError(message: "No results"));
      }
    } catch (e) {
      emit(AIError(message: 'Error performing image recognition: $e'));
    }
  }

  @override
  Future<void> close() {
    Tflite.close();
    return super.close();
  }
}

