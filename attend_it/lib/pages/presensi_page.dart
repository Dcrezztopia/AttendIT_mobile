import 'package:attend_it/provider/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'camera_page.dart'; // Import your CameraPage file
import 'package:attend_it/widgets/appbar_user_widget.dart';
import 'package:attend_it/widgets/bottom_nav_widget.dart';

class PresensiPage extends ConsumerStatefulWidget {
  const PresensiPage({super.key});

  @override
  _PresensiPageState createState() => _PresensiPageState();
}

class _PresensiPageState extends ConsumerState<PresensiPage> {
  int _currentIndex = 1; // Index for Bottom Navigation Bar

  List<Map<String, dynamic>> schedules = [
    {
      "day": "Senin",
      "time": "07.00 - 12.10",
      "course": "Pemrograman Mobile",
      "lecturer": "Sofyan Noor Arief S.ST.,M.Kom",
      "room": "LKJ2_7T",
      "isActive": true // Attendance is active
    },
    {
      "day": "Senin",
      "time": "14.30 - 18.00",
      "course": "Metodologi Penelitian",
      "lecturer": "Ulla Rosiana",
      "room": "LKJ2_7T",
      "isActive": true // Attendance is not active
    },
    {
      "day": "Selasa",
      "time": "07.00 - 12.10",
      "course": "Pembelajaran Mesin",
      "lecturer": "Ely Setyo Astuti",
      "room": "LKJ2_7T",
      "isActive": false
    },
    {
      "day": "Selasa",
      "time": "14.30 - 16.20",
      "course": "Kewarganegaraan",
      "lecturer": "Dr. Widayaningish",
      "room": "LKJ2_7T",
      "isActive": false
    },
    {
      "day": "Rabu",
      "time": "07.00 - 10.30",
      "course": "Administrasi dan Keamanan Jaringan",
      "lecturer": "Ade Ismail",
      "room": "LKJ2_7T",
      "isActive": true
    },
    {
      "day": "Rabu",
      "time": "14.30 - 18.00",
      "course": "Bahasa Inggris Persiapan Kerja",
      "lecturer": "Atiqah Nurul Asri",
      "room": "LKJ2_7T",
      "isActive": false
    },
  ];

  @override
  void initState() {
    super.initState();
    _sortSchedules(); // Sort schedules when the page is loaded
    // // Panggil fetchSchedules untuk mengambil data
    // Future.microtask(() => ref.read(scheduleProvider.notifier).fetchSchedules());
  }

  void activateSchedule(int index) {
    setState(() {
      for (int i = 0; i < schedules.length; i++) {
        schedules[i]['isActive'] = i == index; // Set active state
      }
      _sortSchedules(); // Move active ones to the top
    });
  }

  // Function to sort schedules with active ones at the top
  void _sortSchedules() {
    schedules.sort((a, b) {
      // Compare based on the 'isActive' boolean value, converting them to integers (1 for true, 0 for false)
      return (b['isActive'] ? 1 : 0).compareTo(a['isActive'] ? 1 : 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheduleState = ref.watch(scheduleProvider);

    return Scaffold(
      appBar: const AppbarUserWidget(),
      body: ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final schedule = schedules[index];
          final isActive = schedule['isActive'] ?? true;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onTap: isActive
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CameraPage(schedule: schedule),
                        ),
                      );
                    }
                  : null, // Disable tap if not active
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: isActive ? 4 : 0, // No elevation for inactive
                color: isActive
                    ? Colors.white
                    : Colors.grey[300], // White for active, grey for inactive
                shadowColor: isActive
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
                                schedule['time'] ?? '',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isActive
                                      ? Colors.black
                                      : Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            schedule['day'] ?? '', // Display the "day" text
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isActive ? Colors.black : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.grey),
                      Text(
                        schedule['course'] ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isActive ? Colors.black : Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          const Icon(Icons.person, color: Color(0xFF0047AB)),
                          const SizedBox(width: 7),
                          Text(
                            schedule['lecturer'] ?? '',
                            style: TextStyle(
                              fontSize: 13,
                              color: isActive ? Colors.black : Colors.grey[600],
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
                            schedule['room'] ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: isActive ? Colors.grey : Colors.grey[600],
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
      // body: scheduleState.when(
      //   loading: () => const Center(child: CircularProgressIndicator()),
      //   error: (e, stack) => Center(child: Text('Error: $e')),
      //   data: (schedules){
      //     return ListView.builder(
      //       itemCount: schedules.length,
      //       itemBuilder: (context, index) {
      //         final schedule = schedules[index];
      //         final isActive = schedule.status == '1';
          
      //         return Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //           child: GestureDetector(
      //             onTap: isActive
      //                 ? () {
      //                     Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                         builder: (context) => CameraPage(schedule: schedule),
      //                       ),
      //                     );
      //                   }
      //                 : null, // Disable tap if not active
      //             child: Card(
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(16),
      //               ),
      //               elevation: isActive ? 4 : 0, // No elevation for inactive
      //               color: isActive
      //                   ? Colors.white
      //                   : Colors.grey[300], // White for active, grey for inactive
      //               shadowColor: isActive
      //                   ? const Color.fromARGB(255, 31, 30, 30).withOpacity(0.3)
      //                   : null,
      //               child: Padding(
      //                 padding: const EdgeInsets.all(16.0),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     // Row for Time and Day
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         Row(
      //                           children: [
      //                             const Icon(Icons.access_time,
      //                                 color: Color(0xFF0047AB)),
      //                             const SizedBox(width: 6),
      //                             Text(
      //                               '${schedule.timeStart} - ${schedule.timeEnd}',
      //                               style: TextStyle(
      //                                 fontSize: 14,
      //                                 fontWeight: FontWeight.bold,
      //                                 color: isActive
      //                                     ? Colors.black
      //                                     : Colors.grey[600],
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                         Text(
      //                           schedule.day, // Display the "day" text
      //                           style: TextStyle(
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.bold,
      //                             color: isActive ? Colors.black : Colors.grey[600],
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     const Divider(color: Colors.grey),
      //                     Text(
      //                       schedule.namaMatkul,
      //                       style: TextStyle(
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.w600,
      //                         color: isActive ? Colors.black : Colors.grey[600],
      //                       ),
      //                     ),
      //                     const SizedBox(height: 7),
      //                     Row(
      //                       children: [
      //                         const Icon(Icons.person, color: Color(0xFF0047AB)),
      //                         const SizedBox(width: 7),
      //                         Text(
      //                           schedule.namaDosen,
      //                           style: TextStyle(
      //                             fontSize: 13,
      //                             color: isActive ? Colors.black : Colors.grey[600],
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     const SizedBox(height: 7),
      //                     Row(
      //                       children: [
      //                         const Icon(Icons.location_on,
      //                             color: Color(0xFF0047AB)),
      //                         const SizedBox(width: 7),
      //                         Text(
      //                           schedule.room,
      //                           style: TextStyle(
      //                             fontSize: 14,
      //                             color: isActive ? Colors.grey : Colors.grey[600],
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
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
