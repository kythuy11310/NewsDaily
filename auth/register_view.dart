import 'package:flutter/material.dart';
import '../core/auth/auth_service.dart';
import '../news/widgets/app_styles.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String _errorMessage = '';

  void _handleRegister() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final error = await _authService.register(
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _nameController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (error == null) {
      // Đăng ký thành công, tự động quay về trang chủ
      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      setState(() => _errorMessage = error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgWhite,
      appBar: AppBar(title: const Text('Đăng ký tài khoản'), backgroundColor: AppStyles.primaryRed),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(_errorMessage, style: const TextStyle(color: Colors.red)),
              ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Họ và tên', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Mật khẩu', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _handleRegister,
              style: ElevatedButton.styleFrom(backgroundColor: AppStyles.primaryRed, padding: const EdgeInsets.symmetric(vertical: 16)),
              child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white) 
                  : const Text('Hoàn tất Đăng ký', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}