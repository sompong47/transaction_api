import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:form_validate/services/storage_service.dart';
import 'package:form_validate/utils/api.dart';
import 'package:get/get.dart';
import 'package:form_validate/components/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // ✨ NEW: สำหรับจัดรูปแบบวันที่และตัวเลข

import '../components/transaction_card.dart';
import '../controllers/auth_controller.dart';
import '../controllers/transac_controller.dart';
import '../model/transaction.dart';
import 'transaction_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController authController = Get.put(AuthController());
  final TransactionController transactionController =
      Get.put(TransactionController());
  final StorageService _storageService = StorageService();

  // ✨ UPDATED: แยก Future ออกมาเพื่อให้เรียกใช้แค่ครั้งเดียวใน initState
  late Future<List<TransactionData>> _transactionFuture;

  @override
  void initState() {
    super.initState();
    _transactionFuture = _getAllTransaction();
  }

  Future<List<TransactionData>> _getAllTransaction() async {
    await _storageService.init();

    final token = _storageService.getToken();
    final serviceUrl = '$BASE_URL$TRANSACTION_ENDPOINT';

    try {
      var response = await http.get(
        Uri.parse(serviceUrl),
        headers: {
          'Content-Type': 'application/json',
          "app_version": "1.2.0",
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        debugPrint('Failed to load transactions: ${response.reasonPhrase}');
        throw Exception('Failed to load transactions');
      } else {
        final json = jsonDecode(response.body);
        final list = json['data'] as List<dynamic>;
        final transactions = list
            .map((item) => TransactionData.fromJson(item as Map<String, dynamic>))
            .toList();
            
        // ✨ NEW: เรียงลำดับรายการล่าสุดขึ้นก่อน
        transactions.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

        transactionController.setTransactions(transactions);
        return transactionController.transactions;
      }
    } catch (e) {
      debugPrint('Error fetching transactions: $e');
      return []; // คืนค่าเป็น List ว่างในกรณีที่เกิด Error
    }
  }

  // ✨ NEW: ฟังก์ชันสำหรับ Refresh ข้อมูล
  Future<void> _refreshTransactions() async {
    setState(() {
      _transactionFuture = _getAllTransaction();
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✨ NEW: กำหนดสีหลัก
    final Color primaryColor = Colors.blue.shade800;
    final Color backgroundColor = Colors.grey.shade100;

    return Scaffold(
      backgroundColor: backgroundColor, // ✨ NEW: กำหนดสีพื้นหลัง
      appBar: AppBar(
        title: const Text(
          'Financial Record',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: primaryColor, // ✨ UPDATED: ใช้สีหลัก
        elevation: 2, // ✨ NEW: เพิ่มเงาเล็กน้อย
        iconTheme: const IconThemeData(color: Colors.white), // ✨ NEW: เปลี่ยนสีไอคอน Drawer เป็นสีขาว
      ),
      drawer: AppDrawer(),
      body: Container(
        // ✨ NEW: เพิ่ม Gradient ให้พื้นหลังดูมีมิติ
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor.withOpacity(0.1), backgroundColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<TransactionData>>(
          future: _transactionFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: primaryColor));
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red.shade700)),
              );
            } else {
              // ✨ UPDATED: ใช้ RefreshIndicator เพื่อให้ผู้ใช้ดึงเพื่อรีเฟรชได้
              return RefreshIndicator(
                onRefresh: _refreshTransactions,
                color: primaryColor,
                child: Obx(
                  () {
                    if (transactionController.transactions.isEmpty) {
                      // ✨ NEW: แสดงผลเมื่อไม่มีข้อมูล (Empty State)
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inbox_rounded, size: 80, color: Colors.grey.shade400),
                            const SizedBox(height: 16),
                            Text(
                              'No transactions yet',
                              style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                            ),
                            const Text(
                              'Tap the "+" button to add your first transaction.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(8.0), // ✨ NEW: เพิ่ม Padding รอบๆ ListView
                      itemCount: transactionController.transactions.length,
                      itemBuilder: (context, index) {
                        return TransacCard(
                          transaction: transactionController.transactions[index],
                        );
                      },
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            // ✨ NEW: ทำให้ BottomSheet ขอบมนด้านบน
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.8,
                minChildSize: 0.5,
                maxChildSize: 0.9,
                builder: (context, scrollController) {
                  return ClipRRect( // ✨ NEW: ครอบเพื่อให้ content ข้างในไม่ล้นขอบมน
                     borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          controller: scrollController,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40.0), // ✨ NEW: เพิ่มที่ว่างด้านบนให้ปุ่มปิด
                            child: const TransactionForm(),
                          ),
                        ),
                        // ✨ UPDATED: ปรับปรุงปุ่มปิดให้สวยงามขึ้น
                        Positioned(
                          top: 12,
                          right: 12,
                          child: InkWell(
                             borderRadius: BorderRadius.circular(30),
                             onTap: () => Navigator.of(context).pop(),
                             child: Container(
                               padding: const EdgeInsets.all(4),
                               decoration: BoxDecoration(
                                 color: Colors.grey.shade200,
                                 shape: BoxShape.circle,
                               ),
                               child: const Icon(Icons.close, size: 24, color: Colors.black54),
                             ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            // ✨ NEW: เมื่อเพิ่มข้อมูลเสร็จให้ทำการ refresh หน้าจอ
          ).then((value) {
             if (value == true) { // สมมติว่า TransactionForm คืนค่า true เมื่อมีการเพิ่มข้อมูลสำเร็จ
                _refreshTransactions();
             }
          });
        },
        backgroundColor: primaryColor, // ✨ UPDATED: ใช้สีหลัก
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}