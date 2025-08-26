import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:form_validate/utils/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/navigation_helper.dart';
import '../services/storage_service.dart';

// AuthController สำหรับจัดการ state ของการ authentication
class AuthController extends GetxController {
  // Observable variables
  final _isLoggedIn = false.obs;
  final _isLoading = false.obs;
  final _currentUser = Rxn<User>();

  final StorageService _storageService = StorageService();

  // Getters
  bool get isLoggedIn => _isLoggedIn.value;
  bool get isLoading => _isLoading.value;
  User? get currentUser => _currentUser.value;

  @override
  void onInit() {
    super.onInit();
    // Initialize storage service แล้วตรวจสอบสถานะการล็อกอิน
    _initStorageAndCheckLogin();
  }

  Future<void> _initStorageAndCheckLogin() async {
    await _storageService.init();
    _checkLoginStatus();
  }

  // ตรวจสอบสถานะการล็อกอิน
  Future<void> _checkLoginStatus() async {
    try {
      final token = _storageService.getToken();
      if (token != null && token.isNotEmpty) {
        // โหลดข้อมูล user จาก storage
        final userData = _storageService.getUser();
        if (userData != null) {
          final user = User.fromJson(userData);
          _setCurrentUser(user);
        }
        _setLoggedIn(true);
      } else {
        _setLoggedIn(false);
      }
    } catch (e) {
      debugPrint('Error checking login status: $e');
      _setLoggedIn(false);
    }
  }

  // ฟังก์ชันล็อกอิน
  Future<bool> login({required String email, required String password}) async {
    try {
      _setLoading(true);

      // จำลองการเรียก API
      await Future.delayed(const Duration(seconds: 2));

      final serviceUrl = '$BASE_URL$LOGIN_ENDPOINT';

      var url = Uri.parse(serviceUrl);
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // login สำเร็จ
        final data = jsonDecode(response.body);
        final token = data['data']['access'];

        // ดึงข้อมูลผู้ใช้
        final userData = data['data']['auth'];

        // สร้าง User object
        final user = User(
          id: userData['uuid'] ?? '',
          email: userData['name'] ?? '',
          firstName: userData['first_name'] ?? '',
          lastName: userData['last_name'] ?? '',
          profileImage: null, // หากไม่มีข้อมูลรูปภาพ
        );
        _setCurrentUser(user);

        // บันทึก token และข้อมูล user ลงใน local storage
        await _storageService.saveToken(token);
        await _storageService.saveUser(user.toJson());

        _setLoggedIn(true);

        NavigationHelper.toHome(clearStack: true);

        return true;
      } else {
        // login ไม่สำเร็จ
        NavigationHelper.showErrorSnackBar('อีเมลหรือรหัสผ่านไม่ถูกต้อง');
        return false;
      }
    } catch (e) {
      NavigationHelper.showErrorSnackBar('เกิดข้อผิดพลาด: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ฟังก์ชันสมัครสมาชิก
  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);

      // จำลองการเรียก API
      await Future.delayed(const Duration(seconds: 2));

      final serviceUrl = '$BASE_URL$REGISTER_ENDPOINT';
      var url = Uri.parse(serviceUrl);
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': email,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
        }),
      );

      if (response.statusCode == 201) {
        // แสดงผลสำเร็จ
        NavigationHelper.showSuccessSnackBar('สมัครสมาชิกสำเร็จ');
        // กลับไปหน้า Login
        await Future.delayed(const Duration(milliseconds: 1500));
        NavigationHelper.offNamed('/login');

        return true;
      } else {
        NavigationHelper.showErrorSnackBar(
          'สมัครสมาชิกไม่สำเร็จ: ${response.reasonPhrase}',
        );

        _setLoading(false);
        return false;
      }
    } catch (e) {
      NavigationHelper.showErrorSnackBar('เกิดข้อผิดพลาด: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ฟังก์ชันรีเซ็ตรหัสผ่าน
  Future<bool> resetPassword(String email) async {
    try {
      _setLoading(true);

      // จำลองการเรียก API
      await Future.delayed(const Duration(seconds: 2));

      NavigationHelper.showSuccessSnackBar(
        'ส่งลิงก์รีเซ็ตรหัสผ่านไปยังอีเมลของคุณแล้ว',
      );

      return true;
    } catch (e) {
      NavigationHelper.showErrorSnackBar('เกิดข้อผิดพลาด: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ฟังก์ชันล็อกเอาต์
  Future<void> logout() async {
    try {
      _setLoading(true);

      // ลบ token และข้อมูลผู้ใช้
      await _storageService.deleteToken();
      await _storageService.deleteUser();

      _setLoggedIn(false);
      _setCurrentUser(null);

      NavigationHelper.showSuccessSnackBar('ออกจากระบบแล้ว');
      NavigationHelper.toLogin(clearStack: true);
    } catch (e) {
      NavigationHelper.showErrorSnackBar('เกิดข้อผิดพลาด: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Helper methods
  void _setLoading(bool value) {
    _isLoading.value = value;
  }

  void _setLoggedIn(bool value) {
    _isLoggedIn.value = value;
  }

  void _setCurrentUser(User? user) {
    _currentUser.value = user;
  }
}

// User model
class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? profileImage;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profileImage,
  });

  String get fullName => '$firstName $lastName';

  // Convert to/from JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profileImage': profileImage,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profileImage: json['profileImage'],
    );
  }
}

// Binding สำหรับ Dependency Injection
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
