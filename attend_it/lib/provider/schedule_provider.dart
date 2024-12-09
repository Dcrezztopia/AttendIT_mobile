import 'package:attend_it/models/schedule.dart';
import 'package:attend_it/services/schedule_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scheduleProvider = StateNotifierProvider<ScheduleNotifier, AsyncValue<List<Schedule>>>((ref) {
  return ScheduleNotifier();
});

class ScheduleNotifier extends StateNotifier<AsyncValue<List<Schedule>>> {
  ScheduleNotifier() : super(const AsyncLoading());

  Future<void> fetchSchedules() async {
    try {
      final data = await ScheduleService().getSchedules();
      state = AsyncData(data);
    } catch (e) {
      state = AsyncError(e, StackTrace as StackTrace);
    }
  }

  void sortSchedules() {
    if (state is AsyncData<List<Schedule>>) {
      final data = (state as AsyncData<List<Schedule>>).value;
      data.sort((a, b) => b.status.compareTo(a.status));
      state = AsyncData([...data]); // Emit updated state
    }
  }
}
