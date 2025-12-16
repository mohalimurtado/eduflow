import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up (Auth Only)
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'Terjadi kesalahan tidak dikenal: $e';
    }
  }

  // Sign In
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'Terjadi kesalahan tidak dikenal: $e';
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get Current User
  User? get currentUser => _auth.currentUser;

  // Error Handler
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      // Register
      case 'email-already-in-use':
        return 'Email sudah terdaftar. Gunakan email lain.';
      case 'invalid-email':
        return 'Format email tidak valid.';
      case 'operation-not-allowed':
        return 'Operasi ini tidak diizinkan.';
      case 'weak-password':
        return 'Password terlalu lemah.';
      
      // Login
      case 'user-not-found':
        return 'Pengguna tidak ditemukan. Silakan daftar.';
      case 'wrong-password':
        return 'Password salah.';
      case 'user-disabled':
        return 'Akun pengguna ini telah dinonaktifkan.';
      case 'invalid-credential':
        return 'Kredensial tidak valid.';
        
      default:
        return 'Terjadi kesalahan: ${e.message}';
    }
  }
}
