import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class AcademicTranscriptScreen extends StatelessWidget {
  const AcademicTranscriptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Transkrip Nilai'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Summary Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Indeks Prestasi Kumulatif',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '3.85',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Total 112 SKS',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                    ),
                    child: const Icon(Icons.school, color: Colors.white, size: 40),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Semester List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 4, // 4 Semesters mock
              itemBuilder: (context, index) {
                int semester = 6 - index;
                return _buildSemesterCard(semester);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSemesterCard(int semester) {
    // Mock courses
    final courses = [
      {'code': 'CS301', 'name': 'Pemrograman Mobile', 'sks': 3, 'grade': 'A'},
      {'code': 'CS302', 'name': 'Kecerdasan Buatan', 'sks': 3, 'grade': 'A-'},
      {'code': 'CS303', 'name': 'Manajemen Proyek', 'sks': 2, 'grade': 'A'},
      {'code': 'CS304', 'name': 'Statistika', 'sks': 3, 'grade': 'B+'},
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
      child: Theme(
        data: Theme.of(null!).copyWith(dividerColor: Colors.transparent), // Fix context access
        child: ExpansionTile(
          initiallyExpanded: semester == 6,
          title: Text(
            'Semester $semester',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF2D3436),
            ),
          ),
          subtitle: Text(
            'IPS: 3.82 • 11 SKS',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          children: [
            const Divider(height: 1),
            ...courses.map((course) => _buildCourseRow(course)),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseRow(Map<String, dynamic> course) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${course['code']} • ${course['sks']} SKS',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _getGradeColor(course['grade'].toString()).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              course['grade'].toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _getGradeColor(course['grade'].toString()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getGradeColor(String grade) {
    if (grade.startsWith('A')) return Colors.green;
    if (grade.startsWith('B')) return Colors.blue;
    if (grade.startsWith('C')) return Colors.orange;
    return Colors.red;
  }
}
