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
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  user?.fullName ?? "Guest",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
                accountEmail: Text(
                  user?.email ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: user?.profileImage != null
                      ? ClipOval(
                          child: Image.network(
                            user!.profileImage!,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(Icons.person, size: 40, color: Colors.blueAccent),
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
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
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.white),
                title: const Text("Home",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                onTap: () {
                  Navigator.of(context).pop();
                  Get.toNamed(AppRoutes.home);
                },
              ),
              Divider(color: Colors.white54, indent: 16, endIndent: 16),
              ListTile(
                leading: const Icon(Icons.list_alt, color: Colors.white),
                title: const Text("รายการธุรกรรม",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                onTap: () {
                  Navigator.of(context).pop();
                  Get.toNamed(AppRoutes.transactionList);
                },
              ),
              Divider(color: Colors.white54, indent: 16, endIndent: 16),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: const Text("โปรไฟล์",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                onTap: () {
                  Navigator.of(context).pop();
                  Get.toNamed(AppRoutes.profile);
                },
              ),
              Divider(color: Colors.white54, indent: 16, endIndent: 16),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text("Logout",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                onTap: () {
                  Navigator.of(context).pop();
                  authController.logout();
                },
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Powered by YourApp",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
