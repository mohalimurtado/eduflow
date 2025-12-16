import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'video_player_screen.dart';
import 'reading_material_screen.dart';

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
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildSessionItem(index + 1);
      },
    );
  }

  Widget _buildSessionItem(int sessionNumber) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            'Sesi $sessionNumber',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          subtitle: const Text('Pengenalan & Konsep Dasar'),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  _buildSubItem(
                    Icons.article, 
                    'Materi Pengenalan', 
                    'PDF', 
                    () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReadingMaterialScreen(title: 'Materi Pengenalan'))),
                  ),
                  _buildSubItem(
                    Icons.play_circle, 
                    'Video Pembelajaran', 
                    'Video', 
                    () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VideoPlayerScreen(title: 'Video Pembelajaran'))),
                  ),
                  if (sessionNumber % 2 != 0) // Example condition for quiz
                    _buildSubItem(Icons.quiz, 'Kuis Sesi $sessionNumber', 'Kuis', () {}), // Quiz will be implemented next
                ],
              ),
            ),
          ],
        ),
      ),
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
