import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class StudentScheduleScreen extends StatelessWidget {
  const StudentScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          title: const Text('Jadwal Kuliah'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Senin'),
              Tab(text: 'Selasa'),
              Tab(text: 'Rabu'),
              Tab(text: 'Kamis'),
              Tab(text: 'Jumat'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildScheduleList('Senin'),
            _buildScheduleList('Selasa'),
            _buildScheduleList('Rabu'),
            _buildScheduleList('Kamis'),
            _buildScheduleList('Jumat'),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleList(String day) {
    // Mock data based on day
    final List<Map<String, String>> schedules = day == 'Senin' 
      ? [
          {
            'course': 'Pemrograman Mobile',
            'time': '08:00 - 10:30',
            'room': 'Gedung A - Lab 201',
            'type': 'Praktikum',
            'lecturer': 'Dosen A'
          },
          {
            'course': 'Manajemen Proyek TI',
            'time': '13:00 - 15:30',
            'room': 'Gedung B - R.304',
            'type': 'Teori',
            'lecturer': 'Dosen B'
          },
        ]
      : day == 'Rabu' 
        ? [
            {
              'course': 'Basis Data Lanjut',
              'time': '08:00 - 10:30',
              'room': 'Gedung A - Lab 202',
              'type': 'Praktikum',
              'lecturer': 'Dosen C'
            },
          ]
        : [];

    if (schedules.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 60, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'Tidak ada jadwal kuliah hari ini',
              style: TextStyle(color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final item = schedules[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Time Pillar
                Container(
                  width: 80,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['time']!.split(' - ')[0],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '-',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['time']!.split(' - ')[1],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: item['type'] == 'Praktikum' 
                                    ? Colors.orange.withOpacity(0.1) 
                                    : Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                item['type']!,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: item['type'] == 'Praktikum' 
                                      ? Colors.orange 
                                      : Colors.blue,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.location_on, size: 14, color: Colors.grey[400]),
                            const SizedBox(width: 4),
                            Text(
                              item['room']!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['course']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3436),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.person, size: 14, color: Colors.grey[400]),
                            const SizedBox(width: 4),
                            Text(
                              item['lecturer']!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
