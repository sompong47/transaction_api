import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                user?.email ?? "",
                style: TextStyle(fontSize: 16),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, size: 40, color: Colors.white),
              ),
              decoration: BoxDecoration(color: Colors.blueAccent),
              otherAccountsPictures: [
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
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.account_box),
            //   title: Text("About"),
            //   onTap: () {},
            // ),
            // ListTile(
            //   leading: Icon(Icons.grid_3x3_outlined),
            //   title: Text("Products"),
            //   onTap: () {},
            // ),
            // ListTile(
            //   leading: Icon(Icons.contact_mail),
            //   title: Text("Contact"),
            //   onTap: () {},
            // ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
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
