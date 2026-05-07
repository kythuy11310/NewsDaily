import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Thư viện lõi của Firebase
import 'firebase_options.dart'; // File cấu hình bảo mật vừa được tạo tự động
import 'news/news_view.dart'; // Màn hình chính của app

// Đổi từ void main() thành Future<void> main() async để đợi Firebase khởi động
Future<void> main() async {
  // Bắt buộc phải có dòng này để Flutter chuẩn bị sẵn sàng trước khi gọi Native Code (Firebase)
  WidgetsFlutterBinding.ensureInitialized();
  
  // Khởi tạo Firebase kết nối với máy chủ Google
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Tắt dải băng đỏ chữ DEBUG ở góc phải màn hình
      title: 'VN Express Clone',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
      ),
      // App sẽ mở màn hình danh sách tin tức đầu tiên
      home: const NewsView(), 
    );
  }
}