import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'video_player_screen.dart';
import 'reading_material_screen.dart';
import '../assignment/assignment_screen.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseTitle;

  const CourseDetailScreen({super.key, required this.courseTitle});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> with SingleTickerProviderStateMixin {
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.primary,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  widget.courseTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                background: Image.asset(
                  'assets/images/home_dashboard.png', // Placeholder
                  fit: BoxFit.cover,
                  color: Colors.black45,
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: AppColors.primary,
                  tabs: const [
                    Tab(text: 'Sesi Pembelajaran'),
                    Tab(text: 'Diskusi'),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildSessionList(),
            const Center(child: Text('Diskusi - Belum tersedia')),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Materi Section
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text(
            'Materi',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2d3436),
            ),
          ),
        ),
        
        // Session Items 1-3
        for (int i = 1; i <= 3; i++) _buildSessionItem(i),
        
        const SizedBox(height: 24),
        
        // Tugas & Kuis Section
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text(
            'Tugas & Kuis',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2d3436),
            ),
          ),
        ),

        // Session/Assessment Items 4-6
        for (int i = 4; i <= 6; i++) _buildSessionItem(i),
      ],
    );
  }

  Widget _buildSessionItem(int sessionNumber) {
    bool isDone = sessionNumber <= 2;
    
    return StatefulBuilder(
      builder: (context, setState) {
        bool isExpanded = false;
        
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Session number badge
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isDone 
                            ? AppColors.primary.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            '0$sessionNumber',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDone ? AppColors.primary : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Title and subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sessionNumber <= 3 
                                ? 'Pengantar User Interface Design'
                                : sessionNumber == 4
                                  ? 'Tugas Personal 1'
                                  : sessionNumber == 5
                                    ? 'Kuis Pertemuan 1-3'
                                    : 'Tugas Kelompok 1',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2d3436),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '3 URL • 2 Files • 3 Interactive Content',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Status icon
                      Icon(
                        isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: isDone ? Colors.green : Colors.grey,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Expanded content
              if (isExpanded)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Divider(height: 1),
                      _buildSubItem(
                        Icons.article, 
                        'Materi Bacaan', 
                        'PDF', 
                        () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReadingMaterialScreen(title: 'Materi Bacaan'))),
                      ),
                      _buildSubItem(
                        Icons.play_circle, 
                        'Video Pembelajaran', 
                        'Video', 
                        () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VideoPlayerScreen(title: 'Video Pembelajaran'))),
                      ),
                      _buildSubItem(
                        Icons.assignment, 
                        'Tugas/Kuis', 
                        'Quiz', 
                        () => Navigator.push(context, MaterialPageRoute(builder: (_) => AssignmentScreen(title: 'Kuis Sesi $sessionNumber'))),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildSubItem(IconData icon, String title, String type, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          type,
          style: TextStyle(fontSize: 10, color: Colors.grey[800]),
        ),
      ),
      onTap: onTap,
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
