import 'package:flutter_riverpod/flutter_riverpod.dart';

final studentMappingProvider = Provider<StudentMappingService>((ref) {
  return StudentMappingService();
});

class StudentMappingService {
  // This mapping should match your model's training data and database
  final Map<String, String> _modelToDbMapping = {
    'Student A': 'student_id_1',
    'Student B': 'student_id_2',
    // Add mappings for all students in your model
  };

  String? getStudentId(String modelPrediction) {
    return _modelToDbMapping[modelPrediction];
  }

  bool isRecognizedStudent(String modelPrediction) {
    return _modelToDbMapping.containsKey(modelPrediction);
  }
} 