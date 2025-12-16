import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'course/course_detail_screen.dart';

class MyClassesScreen extends StatefulWidget {
  const MyClassesScreen({super.key});

  @override
  State<MyClassesScreen> createState() => _MyClassesScreenState();
}

class _MyClassesScreenState extends State<MyClassesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Kelas Saya',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller._tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'Sedang Berjalan'),
            Tab(text: 'Selesai'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildClassList([
            _ClassData(
              'Pemrograman Mobile',
              'Sistem Informasi',
              70,
              'Senin, 08:00 - 10:00',
              'Gedung D3.1',
              'Dr. John Doe',
            ),
             _ClassData(
              'Basis Data Terdistribusi',
              'Teknik Informatika',
              0, // 0% progress
              'Selasa, 10:00 - 12:00',
              'Lab Komputer 3',
              'Prof. Jane Smith',
            ),
             _ClassData(
              'Pemrograman Web Lanjut',
              'Sistem Informasi',
              30,
              'Rabu, 13:00 - 15:00',
              'Gedung D2.4',
              'Dr. Alan Turing',
            ),
          ]),
          _buildClassList([
             _ClassData(
              'Algoritma & Pemrograman',
              'Sistem Informasi',
              100, // Completed
              'Selesai',
              '-',
              'Dr. Grace Hopper',
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildClassList(List<_ClassData> classes) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final data = classes[index];
        return _buildClassCard(data);
      },
    );
  }

  Widget _buildClassCard(_ClassData data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetailScreen(courseTitle: data.title),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image / Color
            Container(
              height: 100,
              decoration: const BoxDecoration(
                color: AppColors.primaryDark, // Fallback if no image
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                image: DecorationImage(
                  image: AssetImage('assets/images/home_dashboard.png'), // Placeholder using generic
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                ),
              ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  data.category,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      data.lecturer,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.schedule, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      data.schedule,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Progress
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: data.progress / 100,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            data.progress == 100 ? AppColors.success : AppColors.primary,
                          ),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${data.progress}%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: data.progress == 100 ? AppColors.success : AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}

class _ClassData {
  final String title;
  final String category;
  final int progress;
  final String schedule;
  final String location;
  final String lecturer;

  _ClassData(this.title, this.category, this.progress, this.schedule, this.location, this.lecturer);
}
