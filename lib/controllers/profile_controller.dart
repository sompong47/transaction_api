import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/storage_service.dart';
import '../utils/api.dart';
import '../model/user.dart';

class ProfileController extends GetxController {
  final StorageService _storageService = StorageService();

  // ข้อมูลโปรไฟล์
  var user = Rxn<User>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile(); // โหลดข้อมูลตอนเริ่มต้น
  }

  Future<void> fetchProfile() async {
    await _storageService.init();
    final token = _storageService.getToken();

    if (token == null) return;

    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/api/user/profile'), // ปรับให้ตรงกับ API ของคุณ
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        user.value = User.fromJson(data); // แปลง JSON เป็น Model User
      } else {
        print('Failed to load profile: ${response.body}');
      }
    } catch (e) {
      print('Error fetching profile: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
