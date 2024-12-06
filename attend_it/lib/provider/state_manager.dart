import 'package:flutter_riverpod/flutter_riverpod.dart';

final recognitionStateProvider = StateProvider<RecognitionState>((ref) {
  return RecognitionState.idle;
});

enum RecognitionState { idle, loading, success, error }
