import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class HistoryStudyScreen extends StatelessWidget {
  const HistoryStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data: Chronological order (newest first)
    final historyData = [
      {
        'semester': 'Semester 6 (Genap 2023/2024)',
        'courses': [
          {'name': 'Pemrograman Mobile', 'sks': 3, 'status': 'Lulus', 'grade': 'A'},
          {'name': 'Metodologi Penelitian', 'sks': 2, 'status': 'Lulus', 'grade': 'A-'},
          {'name': 'Kerja Praktik', 'sks': 2, 'status': 'Sedang Berjalan', 'grade': '-'},
        ]
      },
      {
        'semester': 'Semester 5 (Ganjil 2023/2024)',
        'courses': [
          {'name': 'Kecerdasan Buatan', 'sks': 3, 'status': 'Lulus', 'grade': 'B+'},
          {'name': 'Manajemen Proyek TI', 'sks': 3, 'status': 'Lulus', 'grade': 'A'},
          {'name': 'Keamanan Informasi', 'sks': 3, 'status': 'Lulus', 'grade': 'B'},
          {'name': 'Analisis Perancangan Sistem', 'sks': 4, 'status': 'Lulus', 'grade': 'A-'},
        ]
      },
      {
        'semester': 'Semester 4 (Genap 2022/2023)',
        'courses': [
          {'name': 'Basis Data Lanjut', 'sks': 3, 'status': 'Lulus', 'grade': 'A'},
          {'name': 'Statistika Probabilitas', 'sks': 3, 'status': 'Lulus', 'grade': 'B'},
          {'name': 'Sistem Operasi', 'sks': 3, 'status': 'Lulus', 'grade': 'B+'},
        ]
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Riwayat Studi'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: historyData.length,
        itemBuilder: (context, index) {
          final semesterData = historyData[index];
          return _buildSemesterGroup(semesterData);
        },
      ),
    );
  }

  Widget _buildSemesterGroup(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                data['semester'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3436),
                ),
              ),
            ],
          ),
        ),
        ...(data['courses'] as List<dynamic>).map((course) => _buildCourseItem(course)),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildCourseItem(Map<String, dynamic> course) {
    final bool isPassed = course['status'] == 'Lulus';
    final bool isOngoing = course['status'] == 'Sedang Berjalan';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon Status
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isPassed 
                  ? Colors.green.withOpacity(0.1) 
                  : (isOngoing ? Colors.blue.withOpacity(0.1) : Colors.red.withOpacity(0.1)),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPassed ? Icons.check_circle : (isOngoing ? Icons.timelapse : Icons.cancel),
              color: isPassed ? Colors.green : (isOngoing ? Colors.blue : Colors.red),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF2D3436),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${course['sks']} SKS • ${course['status']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // Grade
          if (course['grade'] != '-')
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                course['grade'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF2D3436),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
