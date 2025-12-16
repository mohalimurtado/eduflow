import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class QuizStartScreen extends StatelessWidget {
  const QuizStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Quiz Review 1'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/user_profile.png', // Placeholder icon
              height: 80,
            ),
            const SizedBox(height: 24),
            const Text(
              'Siap Mengerjakan?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Waktu akan berjalan otomatis setelah anda menekan tombol mulai.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                   Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Mulai Sekarang'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _selectedOption = -1;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Radio button dapat digunakan untuk menentukan?',
      'options': ['Jenis Kelamin', 'Alamat', 'Hobby', 'Riwayat Pendidikan', 'Umur'],
      'correctAnswer': 0,
    },
    {
      'question': 'Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu?',
      'options': ['Intergrasi', 'Standarisasi', 'Konsistensi', 'Koefensi', 'Koreksi'],
      'correctAnswer': 2,
    },
    // Add more dummy questions if needed
  ];

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOption = -1;
      });
    } else {
      // Finish Quiz
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Selesai'),
          content: const Text('Anda telah menyelesaikan kuis ini.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Kembali ke Dashboard'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Review 1'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.timer, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text('14:32', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Number Strip
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  15, // Mock 15 questions
                  (index) => Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == _currentQuestionIndex
                          ? AppColors.primary
                          : Colors.transparent,
                      border: Border.all(
                        color: index <= _currentQuestionIndex
                            ? AppColors.primary
                            : Colors.grey,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: index == _currentQuestionIndex
                            ? Colors.white
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Question Text
            Text(
              'Soal Nomor ${_currentQuestionIndex + 1} / 15',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 24),
            Text(
              question['question'],
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 32),

            // Options
            ...List.generate(
              (question['options'] as List).length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedOption = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _selectedOption == index
                          ? AppColors.primary.withOpacity(0.1)
                          : Colors.grey[100],
                      border: Border.all(
                        color: _selectedOption == index
                            ? AppColors.primary
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          String.fromCharCode(65 + index) + '.', // A, B, C...
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _selectedOption == index
                                ? AppColors.primary
                                : Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            question['options'][index],
                            style: TextStyle(
                              color: _selectedOption == index
                                  ? AppColors.primary
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentQuestionIndex > 0)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _currentQuestionIndex--;
                        _selectedOption = -1; // Reset selection for demo simple state
                      });
                    },
                    child: const Text('Soal Sebelumnya'),
                  )
                else
                  const SizedBox(),
                  
                ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    _currentQuestionIndex == _questions.length - 1
                        ? 'Selesai'
                        : 'Soal Selanjutnya',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
