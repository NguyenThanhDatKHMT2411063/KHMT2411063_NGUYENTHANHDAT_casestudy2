import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'change_password_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final String userId;
  final String userName;

  const HomeScreen({super.key, required this.userId, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xin chào, $userName'),
        actions: [
          // Nút Đăng xuất nhanh trên AppBar
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Đăng xuất',
            onPressed: () {
              // Chuyển hướng về màn hình đăng nhập và xóa sạch lịch sử stack màn hình
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.account_circle, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              'Chào mừng bạn đến với TaskManager!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(userId: userId),
                  ),
                );
              },
              icon: const Icon(Icons.person),
              label: const Text('Xem và Cập Nhật Thông Tin'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePasswordScreen(userId: userId),
                  ),
                );
              },
              icon: const Icon(Icons.lock),
              label: const Text('Đổi Mật Khẩu'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                // Xử lý Đăng xuất
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                );
              },
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text('Đăng Xuất', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}