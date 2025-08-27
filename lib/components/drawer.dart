import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../routes/app_routes.dart'; // อย่าลืมนำเข้าด้วย

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  // ใช้ Get.find เพื่อดึง AuthController ที่ถูก inject แล้ว
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = authController.currentUser;

      return Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                user?.fullName ?? "Guest",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                user?.email ?? "",
                style: const TextStyle(fontSize: 16),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, size: 40, color: Colors.white),
              ),
              decoration: const BoxDecoration(color: Colors.blueAccent),
              otherAccountsPictures: const [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.star, color: Colors.amber),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.favorite, color: Colors.pink),
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.of(context).pop();
                Get.toNamed(AppRoutes.home);
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text("Transactions"),
              onTap: () {
                Navigator.of(context).pop();
                Get.toNamed(AppRoutes.transactionList); // เพิ่มเมนู TransactionList
              },
            ),
            ListTile(
                leading: Icon(Icons.person),
                title: Text("โปรไฟล์"),
                onTap: () {
                  Get.toNamed(AppRoutes.profile);
  },
),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                authController.logout();
              },
            ),
          ],
        ),
      );
    });
  }
}
