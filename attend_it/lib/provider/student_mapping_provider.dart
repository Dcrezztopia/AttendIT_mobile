import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/student_mapping_service.dart';

final studentMappingProvider = Provider<StudentMappingService>((ref) {
  return StudentMappingService();
}); 