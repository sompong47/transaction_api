import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('โปรไฟล์'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        final user = authController.currentUser;
        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                      user.profileImage ??
                          'https://i.pravatar.cc/150?img=3'),
                ),
                const SizedBox(height: 20),
                Text(user.fullName,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text("Email: ${user.email}", style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 5),
                
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () => authController.logout(),
                  icon: const Icon(Icons.logout),
                  label: const Text("ออกจากระบบ"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
