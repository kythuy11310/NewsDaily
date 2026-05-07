import 'package:flutter/material.dart';
import '../core/auth/auth_service.dart';
import '../auth/login_view.dart';
import '../news/widgets/app_styles.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    if (_authService.currentUser == null) {
      setState(() => _isLoading = false);
      return;
    }
    
    final data = await _authService.getUserProfile();
    setState(() {
      _userData = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Nếu chưa đăng nhập, hiển thị nút mời đăng nhập
    if (_authService.currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Cá nhân'), backgroundColor: AppStyles.primaryRed),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              // Chờ người dùng đi đăng nhập về
              await Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginView()));
              // Tải lại trang profile
              setState(() => _isLoading = true);
              _loadUserProfile();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppStyles.primaryRed),
            child: const Text('Đăng nhập để xem hồ sơ'),
          ),
        ),
      );
    }

    // Đã đăng nhập, hiển thị thông tin từ Server
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ của tôi'),
        backgroundColor: AppStyles.primaryRed,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Họ và tên', style: TextStyle(color: Colors.grey)),
              subtitle: Text(_userData?['fullName'] ?? 'Đang cập nhật...', style: const TextStyle(fontSize: 18, color: Colors.black)),
            ),
            const Divider(),
            ListTile(
              title: const Text('Email', style: TextStyle(color: Colors.grey)),
              subtitle: Text(_userData?['email'] ?? '', style: const TextStyle(fontSize: 18, color: Colors.black)),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  await _authService.logout();
                  setState(() => _userData = null); // Xóa data hiển thị
                },
                style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
                child: const Text('Đăng xuất'),
              ),
            )
          ],
        ),
      ),
    );
  }
}