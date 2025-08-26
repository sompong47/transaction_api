import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class NavigationHelper {
  NavigationHelper._();

  // การนำทางแบบต่างๆ

  /// นำทางไปยังหน้าใหม่ (push)
  static Future<T?>? toNamed<T>(String routeName, {dynamic arguments}) {
    return Get.toNamed<T>(routeName, arguments: arguments);
  }

  /// นำทางไปยังหน้าใหม่และลบหน้าปัจจุบัน (replace)
  static Future<T?>? offNamed<T>(String routeName, {dynamic arguments}) {
    return Get.offNamed<T>(routeName, arguments: arguments);
  }

  /// นำทางไปยังหน้าใหม่และลบทุกหน้าที่ผ่านมา (clear stack)
  static Future<T?>? offAllNamed<T>(String routeName, {dynamic arguments}) {
    return Get.offAllNamed<T>(routeName, arguments: arguments);
  }

  /// กลับไปหน้าก่อนหน้า
  static void back<T>([T? result]) {
    Get.back<T>(result: result);
  }

  /// ตรวจสอบว่าสามารถกลับได้หรือไม่
  static bool canPop() {
    return Get.isDialogOpen! ||
        Get.isBottomSheetOpen! ||
        Navigator.canPop(Get.context!);
  }

  // Methods เฉพาะสำหรับแอปนี้

  /// ไปหน้า Splash Screen
  static Future<void> toSplash({bool clearStack = false}) async {
    if (clearStack) {
      await offAllNamed(AppRoutes.splash);
    } else {
      await toNamed(AppRoutes.splash);
    }
  }

  /// ไปหน้า Login
  static Future<void> toLogin({bool clearStack = false}) async {
    if (clearStack) {
      await offAllNamed(AppRoutes.login);
    } else {
      await toNamed(AppRoutes.login);
    }
  }

  /// ไปหน้า Register
  static Future<void> toRegister() async {
    await toNamed(AppRoutes.register);
  }

  /// ไปหน้า Forget Password
  static Future<void> toForgetPassword() async {
    await toNamed(AppRoutes.forgetPassword);
  }

  /// ไปหน้า Home (สำหรับอนาคต)
  static Future<void> toHome({bool clearStack = true}) async {
    if (clearStack) {
      await offAllNamed(AppRoutes.home);
    } else {
      await toNamed(AppRoutes.home);
    }
  }

  // Utility methods

  /// แสดง SnackBar
  static void showSnackBar({
    required String message,
    String? title,
    SnackPosition? position,
    Color? backgroundColor,
    Color? colorText,
    Duration? duration,
  }) {
    Get.snackbar(
      title ?? 'แจ้งเตือน',
      message,
      snackPosition: position ?? SnackPosition.TOP,
      backgroundColor: backgroundColor ?? Get.theme.primaryColor,
      colorText: colorText ?? Get.theme.colorScheme.onPrimary,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }

  /// แสดง Success SnackBar
  static void showSuccessSnackBar(String message) {
    showSnackBar(
      title: 'สำเร็จ',
      message: message,
      backgroundColor: const Color(0xFF4CAF50),
      colorText: const Color(0xFFFFFFFF),
    );
  }

  /// แสดง Error SnackBar
  static void showErrorSnackBar(String message) {
    showSnackBar(
      title: 'ข้อผิดพลาด',
      message: message,
      backgroundColor: const Color(0xFFF44336),
      colorText: const Color(0xFFFFFFFF),
    );
  }

  /// แสดง Warning SnackBar
  static void showWarningSnackBar(String message) {
    showSnackBar(
      title: 'คำเตือน',
      message: message,
      backgroundColor: const Color(0xFFFF9800),
      colorText: const Color(0xFFFFFFFF),
    );
  }

  /// แสดง Dialog ยืนยัน
  static Future<bool?> showConfirmDialog({
    required String title,
    required String message,
    String confirmText = 'ยืนยัน',
    String cancelText = 'ยกเลิก',
    Color? confirmColor,
    Color? cancelColor,
  }) {
    return Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            style: TextButton.styleFrom(
              foregroundColor: cancelColor ?? Get.theme.colorScheme.onSurface,
            ),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor ?? Get.theme.primaryColor,
            ),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
}
