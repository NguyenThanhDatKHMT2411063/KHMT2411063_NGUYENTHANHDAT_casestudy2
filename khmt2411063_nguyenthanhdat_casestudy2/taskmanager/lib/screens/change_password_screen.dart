import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangePasswordScreen extends StatefulWidget {
  final String userId;
  const ChangePasswordScreen({super.key, required this.userId});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _changePassword() async {
    setState(() { _isLoading = true; });

    try {
      final response = await http.put(
        Uri.parse('http://10.0.2.2:3000/api/auth/change-password/${widget.userId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'oldPassword': _oldPasswordController.text.trim(),
          'newPassword': _newPasswordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Đổi mật khẩu thành công!')),
        );
        Navigator.pop(context); // Quay lại màn hình trước sau khi đổi thành công
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Đổi mật khẩu thất bại!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi kết nối: $e')),
      );
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đổi Mật Khẩu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _oldPasswordController,
              decoration: const InputDecoration(labelText: 'Mật khẩu cũ'),
              obscureText: true,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _newPasswordController,
              decoration: const InputDecoration(labelText: 'Mật khẩu mới'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _changePassword,
              child: const Text('Xác Nhận Đổi Mật Khẩu'),
            ),
          ],
        ),
      ),
    );
  }
}