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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text('บันทึกการเงิน',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    offset: Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              )),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder(
          future: _getAllTransaction(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Column(
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(Icons.list_alt, color: Colors.blueAccent),
                        const SizedBox(width: 8),
                        Text(
                          'รายการธุรกรรมล่าสุด',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Divider(
                    color: Colors.blueAccent.withOpacity(0.3),
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  Expanded(
                    child: Obx(
                      () => transactionController.transactions.isEmpty
                          ? Center(
                              child: Text(
                                'ยังไม่มีรายการธุรกรรม',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              itemCount: transactionController.transactions.length,
                              itemBuilder: (context, index) {
                                return TransacCard(
                                  transaction:
                                      transactionController.transactions[index],
                                );
                              },
                            ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.8,
                minChildSize: 0.5,
                maxChildSize: 1.0,
                builder: (context, scrollController) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.2),
                              blurRadius: 12,
                              offset: const Offset(0, -4),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: TransactionForm(),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: const Icon(Icons.close, size: 28),
                          color: Colors.blueAccent,
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
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }
}