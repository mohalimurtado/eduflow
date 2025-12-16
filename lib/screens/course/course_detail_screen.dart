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
        // Title Materi
        Image.asset('assets/images/title_materi.png', width: 120, alignment: Alignment.centerLeft),
        const SizedBox(height: 16),
        
        // Session Items 1-3
        for (int i = 1; i <= 3; i++) _buildSessionItem(i),
        
        const SizedBox(height: 16),
        // Title Tugas & Kuis
        Image.asset('assets/images/title_tugas_kuis.png', width: 140, alignment: Alignment.centerLeft),
        const SizedBox(height: 16),

        // Session/Assessment Items 4-6
        for (int i = 4; i <= 6; i++) _buildSessionItem(i),
      ],
    );
  }

  Widget _buildSessionItem(int sessionNumber) {
    // Determine status icon based on mock logic (e.g., 1 & 2 done)
    String checkIcon = (sessionNumber <= 2) ? 'assets/images/ic_check_green.png' : 'assets/images/ic_check_grey.png';

    // Mock sub-items visibility
    bool isExpanded = false; 

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              // Session Card Header (Image)
              InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Image.asset(
                      'assets/images/session_0$sessionNumber.png',
                      width: double.infinity,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container( // Fallback if image missing (e.g. session 2/3 which might not be uploaded as session_0x)
                          height: 60,
                          color: Colors.grey[300],
                          alignment: Alignment.center,
                          child: Text('Session $sessionNumber (Image Missing)'),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Image.asset(checkIcon, width: 24),
                    ),
                  ],
                ),
              ),

              // Divider
              Image.asset('assets/images/divider_gradient.png', width: double.infinity, fit: BoxFit.cover),

              // Expanded Content
              if (isExpanded)
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
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
