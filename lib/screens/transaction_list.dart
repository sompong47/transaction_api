import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transac_controller.dart';
import '../components/transaction_card.dart';

class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ดึง controller ที่เคย put ไว้
    final TransactionController transactionController = Get.find<TransactionController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("รายการธุรกรรม"),
      ),
      body: Obx(() {
        if (transactionController.transactions.isEmpty) {
          return const Center(
            child: Text(
              "ยังไม่มีข้อมูลธุรกรรม",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: transactionController.transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactionController.transactions[index];
            return TransacCard(transaction: transaction);
          },
        );
      }),
    );
  }
}
