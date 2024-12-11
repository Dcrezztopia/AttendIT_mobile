import 'package:attend_it/provider/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:attend_it/widgets/appbar_user_widget.dart';
import 'package:attend_it/widgets/bottom_nav_widget.dart';

class PresensiPage extends ConsumerStatefulWidget {
  const PresensiPage({super.key});

  @override
  _PresensiPageState createState() => _PresensiPageState();
}

class _PresensiPageState extends ConsumerState<PresensiPage> {
  int _currentIndex = 1; // Index for Bottom Navigation Bar

  @override
  void initState() {
    super.initState();
    // _sortSchedules(); // Sort schedules when the page is loaded
    // Panggil fetchSchedules untuk mengambil data
    Future.microtask(() => ref.read(scheduleProvider.notifier).fetchSchedules());
  }

  // Function to sort schedules with active ones at the top
  // void _sortSchedules() {
  //   schedules.sort((a, b) {
  //     // Compare based on the 'isActive' boolean value, converting them to integers (1 for true, 0 for false)
  //     return (b['isActive'] ? 1 : 0).compareTo(a['isActive'] ? 1 : 0);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final schedules = ref.watch(scheduleProvider);

    return Scaffold(
      appBar: const AppbarUserWidget(),
      body: schedules.isEmpty
        ? const Center(child: CircularProgressIndicator(),)
        : ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final schedule = schedules[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onTap: schedule.status == '1'
                  ? () {
                       // Simpan jadwal yang dipilih ke provider
                      ref.read(scheduleProvider.notifier).selectSchedule(schedule);
                      context.go('/camera');
                    }
                  : null, // Disable tap if not active
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: schedule.status == '1' ? 4 : 0, // No elevation for inactive
                color: schedule.status == '1'
                    ? Colors.white
                    : Colors.grey[300], // White for active, grey for inactive
                shadowColor: schedule.status == '1'
                    ? const Color.fromARGB(255, 31, 30, 30).withOpacity(0.3)
                    : null,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row for Time and Day
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                                  color: Color(0xFF0047AB)),
                              const SizedBox(width: 6),
                              Text(
                                '${schedule.waktuMulai} - ${schedule.waktuSelesai}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: schedule.status == '1'
                                      ? Colors.black
                                      : Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            schedule.hari, // Display the "day" text
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: schedule.status == '1' ? Colors.black : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.grey),
                      Text(
                        schedule.namaMatkul,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: schedule.status == '1' ? Colors.black : Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          const Icon(Icons.person, color: Color(0xFF0047AB)),
                          const SizedBox(width: 7),
                          Text(
                            schedule.namaDosen,
                            style: TextStyle(
                              fontSize: 13,
                              color: schedule.status == '1' ? Colors.black : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Color(0xFF0047AB)),
                          const SizedBox(width: 7),
                          Text(
                            schedule.ruangKelas,
                            style: TextStyle(
                              fontSize: 14,
                              color: schedule.status == '1' ? Colors.grey : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
