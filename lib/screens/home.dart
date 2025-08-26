import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_validate/services/storage_service.dart';
import 'package:form_validate/utils/api.dart';
import 'package:get/get.dart';
import 'package:form_validate/components/drawer.dart';
import 'package:http/http.dart' as http;

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
  final AuthController authController = Get.find<AuthController>();
  final StorageService _storageService = StorageService();

  // ใช้งาน TransactionController แทน RxList
  final TransactionController transactionController = Get.put(
    TransactionController(),
  );

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
        transactionController.setTransactions(
          list
              .map(
                (item) =>
                    TransactionData.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
        );
      }

      return transactionController.transactions;
    } catch (e) {
      debugPrint('Error fetching transactions: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('บันทึกการเงิน')),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _getAllTransaction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // ใช้ Obx เพื่อให้ GUI อัปเดตเมื่อ transactions เปลี่ยน
            return Obx(
              () => ListView.builder(
                itemCount: transactionController.transactions.length,
                itemBuilder: (context, index) {
                  return TransacCard(
                    transaction: transactionController.transactions[index],
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.8,
                minChildSize: 0.5,
                maxChildSize: 1.0,
                builder: (context, scrollController) {
                  return Stack(
                    children: [
                      SingleChildScrollView(
                        controller: scrollController,
                        child: TransactionForm(),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: const Icon(Icons.close, size: 28),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
