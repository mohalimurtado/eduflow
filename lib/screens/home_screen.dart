import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../services/auth_service.dart';
import 'course/course_detail_screen.dart';
import 'my_classes_screen.dart';
import 'profile/profile_screen.dart';
import 'profile/student_schedule_screen.dart';
import 'profile/academic_transcript_screen.dart';
import 'assignment/assignment_screen.dart';
import 'quiz/quiz_start_screen.dart';
import 'upload_file_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> classes = [
    {
      'name': 'Pemrograman Mobile',
      'sks': '3 SKS',
      'schedule': 'Senin, 08:00 - 10:00',
      'progress': 0.7,
      'icon': Icons.phone_android_rounded,
    },
    {
      'name': 'Pemrograman Web',
      'sks': '3 SKS',
      'schedule': 'Selasa, 10:00 - 12:00',
      'progress': 0.5,
      'icon': Icons.language,
    },
    {
      'name': 'Basis Data',
      'sks': '4 SKS',
      'schedule': 'Rabu, 08:00 - 11:00',
      'progress': 0.8,
      'icon': Icons.storage,
    },
    {
      'name': 'Manajemen Proyek TI',
      'sks': '3 SKS',
      'schedule': 'Kamis, 13:00 - 15:00',
      'progress': 0.6,
      'icon': Icons.work_outline,
    },
    {
      'name': 'Desain UI/UX',
      'sks': '3 SKS',
      'schedule': 'Jumat, 08:00 - 10:00',
      'progress': 0.4,
      'icon': Icons.design_services,
    },
    {
      'name': 'Keamanan Siber',
      'sks': '3 SKS',
      'schedule': 'Senin, 13:00 - 15:00',
      'progress': 0.9,
      'icon': Icons.security,
    },
    {
      'name': 'Jaringan Komputer',
      'sks': '4 SKS',
      'schedule': 'Selasa, 13:00 - 16:00',
      'progress': 0.65,
      'icon': Icons.router,
    },
    {
      'name': 'Algoritma & Struktur Data',
      'sks': '4 SKS',
      'schedule': 'Rabu, 13:00 - 16:00',
      'progress': 0.75,
      'icon': Icons.account_tree,
    },
    {
      'name': 'Kecerdasan Buatan',
      'sks': '3 SKS',
      'schedule': 'Kamis, 08:00 - 10:00',
      'progress': 0.3,
      'icon': Icons.psychology,
    },
    {
      'name': 'Sistem Informasi Manajemen',
      'sks': '3 SKS',
      'schedule': 'Jumat, 13:00 - 15:00',
      'progress': 0.55,
      'icon': Icons.business_center,
    },
  ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Header with Search
            Container(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  // Top Row: Greeting & Profile
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, ${AuthService().currentUser?.email?.split('@')[0] ?? AuthService().currentUser?.displayName ?? 'Pengguna'}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Selamat Datang Kembali',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfileScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                          ),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage('assets/images/user_profile.jpg'),
                            radius: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Search Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey),
                        hintText: 'Cari tugas, materi, atau kelas...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context: context,
                          icon: Icons.check_circle_outline,
                          label: 'Tugas Selesai',
                          value: '12',
                          color: Colors.white.withOpacity(0.2),
                          textColor: Colors.white,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AssignmentScreen(title: 'Tugas Selesai'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          context: context,
                          icon: Icons.pending_actions,
                          label: 'Tugas Menunggu',
                          value: '4',
                          color: Colors.white.withOpacity(0.2),
                          textColor: Colors.white,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AssignmentScreen(title: 'Tugas Menunggu'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Quick Actions (Menu Cepat)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Menu Cepat',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildQuickAction(
                          context,
                          Icons.calendar_today, 
                          'Jadwal', 
                          Colors.blue,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentScheduleScreen())),
                        ),
                        const SizedBox(width: 12),
                        _buildQuickAction(
                          context,
                          Icons.assignment_outlined, 
                          'Tugas', 
                          Colors.orange,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AssignmentScreen(title: 'Tugas Personal 1'))),
                        ),
                        const SizedBox(width: 12),
                        _buildQuickAction(
                          context,
                          Icons.quiz_outlined, 
                          'Ujian', 
                          Colors.purple,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizStartScreen())),
                        ),
                        const SizedBox(width: 12),
                        _buildQuickAction(
                          context,
                          Icons.bar_chart_rounded, 
                          'Nilai', 
                          Colors.green,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AcademicTranscriptScreen())),
                        ),
                        const SizedBox(width: 12),
                        _buildQuickAction(
                          context,
                          Icons.upload_file_rounded, 
                          'Upload', 
                          Colors.teal,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadFileScreen())),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Tugas Terbaru Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tugas Terbaru',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AssignmentScreen(title: 'Semua Tugas')),
                      );
                    },
                    child: const Text('Lihat Semua'),
                  ),
                ],
              ),
            ),

            // Assignment Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildAssignmentCard(
                    context,
                    title: 'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA',
                    courseCode: 'D4SM-42-03 [ADY]',
                    semester: '2021/2',
                    progress: 0.89,
                    color: const Color(0xFFFF9800),
                    isCompleted: true,
                  ),
                  const SizedBox(height: 12),
                  _buildAssignmentCard(
                    context,
                    title: 'KEWARGANEGARAAN',
                    courseCode: 'D4SM-41-GABI [BRO], JUMAT 2',
                    semester: '2021/2',
                    progress: 0.85,
                    color: const Color(0xFFD32F2F),
                    isCompleted: true,
                  ),
                  const SizedBox(height: 12),
                  _buildAssignmentCard(
                    context,
                    title: 'SISTEM OPERASI',
                    courseCode: 'D4SM-44-02 [DDS]',
                    semester: '2021/2',
                    progress: 0.80,
                    color: const Color(0xFF9E9E9E),
                    isCompleted: true,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Section Title (Kelas Saya)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Kelas Saya',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyClassesScreen()),
                      );
                    },
                    child: const Text('Lihat Semua'),
                  ),
                ],
              ),
            ),

            // Course List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: classes.length,
              itemBuilder: (context, index) {
                final course = classes[index];
                return _buildCourseCard(context, course);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: textColor, size: 28),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: textColor.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, Map<String, dynamic> course) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailScreen(courseTitle: course['name']),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              spreadRadius: 2,
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(course['icon'], color: AppColors.primary, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            course['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF2d3436),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              course['sks'],
                              style: const TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.schedule, size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            course['schedule'],
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Progress Kelas',
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                          Text(
                            '${(course['progress'] * 100).toInt()}%',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: course['progress'],
                          backgroundColor: Colors.grey[100],
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentCard(
    BuildContext context, {
    required String title,
    required String courseCode,
    required String semester,
    required double progress,
    required Color color,
    required bool isCompleted,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AssignmentScreen(title: title),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Colored Thumbnail
            Container(
              width: 100,
              height: 120,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.assignment_outlined,
                  size: 40,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Semester Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        semester,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3436),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3436),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Course Code
                    Text(
                      courseCode,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Progress Bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${(progress * 100).toInt()}% Selesai',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            if (isCompleted)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Selesai',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                            minHeight: 6,
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
  }
}
