import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengumuman'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
             margin: const EdgeInsets.only(bottom: 16),
             elevation: 2,
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
             child: Padding(
               padding: const EdgeInsets.all(16),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                     decoration: BoxDecoration(
                       color: AppColors.warning.withOpacity(0.2),
                       borderRadius: BorderRadius.circular(4),
                     ),
                     child: const Text(
                       'Penting',
                       style: TextStyle(color: Color(0xFFE65100), fontSize: 10, fontWeight: FontWeight.bold),
                     ),
                   ),
                   const SizedBox(height: 8),
                   const Text(
                     'Jadwal Libur Semester Ganjil 2025/2026',
                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                   ),
                   const SizedBox(height: 8),
                   Text(
                     'Diberitahukan kepada seluruh mahasiswa bahwa libur semester ganjil akan dimulai pada tanggal...',
                     style: TextStyle(color: Colors.grey[600]),
                   ),
                   const SizedBox(height: 12),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         '16 Dec 2025',
                         style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                       ),
                       TextButton(
                         onPressed: () {
                           // Navigate to detail
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => const AnnouncementDetailScreen()),
                           );
                         },
                         child: const Text('Baca Selengkapnya'),
                       ),
                     ],
                   ),
                 ],
               ),
             ),
          );
        },
      ),
    );
  }
}

class AnnouncementDetailScreen extends StatelessWidget {
  const AnnouncementDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengumuman'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Jadwal Libur Semester Ganjil 2025/2026',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                SizedBox(width: 4),
                Text('16 Dec 2025', style: TextStyle(color: Colors.grey)),
                SizedBox(width: 16),
                Icon(Icons.person, size: 14, color: Colors.grey),
                SizedBox(width: 4),
                Text('Admin Akademik', style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 24),
            // Placeholder Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/announcement_detail.png'), // Placeholder
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Assalamualaikum Wr. Wb.\n\n'
              'Diberitahukan kepada seluruh mahasiswa bahwa libur semester ganjil tahun ajaran 2025/2026 akan dilaksanakan mulai tanggal 20 Desember 2025 sampai dengan 5 Januari 2026.\n\n'
              'Perkuliahan akan aktif kembali pada tanggal 6 Januari 2026.\n\n'
              'Demikian pengumuman ini disampaikan, harap maklum.\n\n'
              'Wassalamualaikum Wr. Wb.',
              style: TextStyle(fontSize: 16, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
