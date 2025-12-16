import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../login_screen.dart';
import 'edit_profile_screen.dart';
import 'student_schedule_screen.dart';
import 'academic_transcript_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // API-like Header using Stack
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Red Background with Curve
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                  ),
                ),
                // Title (Hidden in scroll, but useful context if needed)
                const Positioned(
                  top: 50,
                  child: Text(
                    'Profil Saya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Profile Picture (Overlapping)
                Positioned(
                  bottom: -60,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/user_profile.png'),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 70), // Spacer for overlapping Avatar
            
            // Name & Major
            const Text(
              'Alimurtado',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3436),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '1202194042 • Sistem Informasi',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Stats Row (Academic Info)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _buildStatItem('IPK', '3.85', Colors.blue),
                  _buildDivider(),
                  _buildStatItem('SKS', '112', Colors.green),
                  _buildDivider(),
                  _buildStatItem('Semester', '6', Colors.orange),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Menu Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                   _buildMenuSection(
                    'Akademik',
                    [
                      _buildMenuItem(
                        Icons.school_rounded, 
                        'Riwayat Studi', 
                        () => _showFeatureDialog(context, 'Riwayat Studi') // Placeholder for now
                      ),
                      _buildMenuItem(
                        Icons.description_rounded, 
                        'Transkrip Nilai', 
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AcademicTranscriptScreen()),
                        ),
                      ),
                      _buildMenuItem(
                        Icons.calendar_month_rounded, 
                        'Jadwal Kuliah', 
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const StudentScheduleScreen()),
                        ),
                      ),
                    ],
                  ),
                   const SizedBox(height: 20),
                   _buildMenuSection(
                    'Pengaturan',
                    [
                      _buildMenuItem(
                        Icons.person_rounded, 
                        'Edit Profil', 
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                        ),
                      ),
                      _buildMenuItem(
                        Icons.lock_rounded, 
                        'Ganti Password', 
                        () => _showFeatureDialog(context, 'Ganti Password')
                      ),
                      _buildMenuItem(
                        Icons.settings_rounded, 
                        'Preferensi Aplikasi', 
                        () => _showFeatureDialog(context, 'Preferensi Aplikasi')
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                         Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFEBEE),
                        foregroundColor: AppColors.primary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout_rounded, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Keluar Aplikasi',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widgets
  void _showFeatureDialog(BuildContext context, String featureName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(featureName),
        content: Text('Fitur $featureName akan segera tersedia di pembaruan berikutnya.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey[300],
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3436),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF2D3436),
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 20),
    );
  }
}
