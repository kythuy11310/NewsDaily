import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Lấy thông tin user hiện tại đang đăng nhập
  User? get currentUser => _auth.currentUser;

  // 1. Đăng ký tài khoản và lưu thông tin vào CSDL
  Future<String?> register(String email, String password, String fullName) async {
    try {
      // Bắn lệnh lên server tạo tài khoản
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Nếu thành công, tạo một bản ghi trong CSDL (Collection 'users')
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'fullName': fullName,
        'createdAt': DateTime.now().toIso8601String(),
        'role': 'reader', // Vai trò người dùng mặc định
      });

      return null; // Trả về null nghĩa là thành công, không có lỗi
    } on FirebaseAuthException catch (e) {
      return e.message; // Trả về thông báo lỗi từ server (VD: Email đã tồn tại)
    } catch (e) {
      return e.toString();
    }
  }

  // 2. Đăng nhập
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Thành công
    } on FirebaseAuthException catch (e) {
      return "Tài khoản hoặc mật khẩu không chính xác.";
    }
  }

  // 3. Đăng xuất
  Future<void> logout() async {
    await _auth.signOut();
  }

  // 4. Lấy thông tin cá nhân từ CSDL Server
  Future<Map<String, dynamic>?> getUserProfile() async {
    if (currentUser == null) return null;
    
    DocumentSnapshot doc = await _firestore.collection('users').doc(currentUser!.uid).get();
    if (doc.exists) {
      return doc.data() as Map<String, dynamic>;
    }
    return null;
  }
}