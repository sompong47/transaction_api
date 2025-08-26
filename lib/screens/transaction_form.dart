import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import '../controllers/transac_controller.dart';

import '../model/transaction.dart';
import '../services/storage_service.dart';
import '../utils/api.dart';

class TransactionForm extends StatefulWidget {
  final dynamic transaction;
  const TransactionForm({super.key, this.transaction});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  int _type = -1;
  DateTime? _selectedDate;

  final StorageService _storageService = StorageService();

  final transactionController = Get.find<TransactionController>();

  Future<void> _submitCreateForm() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      await _storageService.init();

      final token = _storageService.getToken();

      final data = {
        "name": _nameController.text,
        "desc": _descController.text,
        "amount": int.tryParse(_amountController.text) ?? 0,
        "type": _type,
        "date": _selectedDate!.toIso8601String().substring(0, 10),
      };

      final serviceUrl = '$BASE_URL$CREATE_TRANSACTION_ENDPOINT';

      var response = await http.post(
        Uri.parse(serviceUrl),
        headers: {
          'Content-Type': 'application/json',
          "app_version": "1.2.0",
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        debugPrint('Transaction Created successfully');
        // เพิ่มข้อมูลใหม่ใน TransactionController
        final responseData = jsonDecode(response.body);
        final newTransaction = TransactionData.fromJson(responseData['data']);
        transactionController.addTransaction(newTransaction);
      } else {
        debugPrint('Failed to create transaction: ${response.reasonPhrase}');
        throw Exception('Failed to create transaction');
      }

      Navigator.of(context).pop();
    }
  }

  Future<void> _submitUpdateForm() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      await _storageService.init();

      final token = _storageService.getToken();

      final data = {
        "name": _nameController.text,
        "desc": _descController.text,
        "amount": int.tryParse(_amountController.text) ?? 0,
        "type": _type,
        "date": _selectedDate!.toIso8601String().substring(0, 10),
      };

      final serviceUrl =
          '$BASE_URL$CREATE_TRANSACTION_ENDPOINT/${widget.transaction.uuid}';

      var response = await http.put(
        Uri.parse(serviceUrl),
        headers: {
          'Content-Type': 'application/json',
          "app_version": "1.2.0",
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        debugPrint('Transaction updated successfully');
        // ปรับปรุงข้อมูลใน TransactionController
        final responseData = jsonDecode(response.body);

        // รักษาข้อมูลเดิมบางส่วนไว้
        responseData['data']['uuid'] = widget.transaction.uuid;
        responseData['data']['createdAt'] = widget.transaction.createdAt;

        final updatedTransaction = TransactionData.fromJson(
          responseData['data'],
        );

        transactionController.updateTransaction(updatedTransaction);
      } else {
        debugPrint('Failed to create transaction: ${response.reasonPhrase}');
        throw Exception('Failed to create transaction');
      }

      Navigator.of(context).pop();
    }
  }

  Future<void> _submitDeleteForm() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      await _storageService.init();

      final token = _storageService.getToken();

      final serviceUrl =
          '$BASE_URL$CREATE_TRANSACTION_ENDPOINT/${widget.transaction.uuid}';

      var response = await http.delete(
        Uri.parse(serviceUrl),
        headers: {
          'Content-Type': 'application/json',
          "app_version": "1.2.0",
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Transaction deleted successfully');
        // อัปเดตข้อมูลใน TransactionController
        transactionController.removeTransaction(widget.transaction.uuid);
      } else {
        debugPrint('Failed to create transaction: ${response.reasonPhrase}');
        throw Exception('Failed to create transaction');
      }

      Navigator.of(context).pop();
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.transaction != null) {
      // ดึงข้อมูลล่าสุดจาก TransactionController ด้วย uuid
      final transactionController = Get.find<TransactionController>();
      final latestTransaction = transactionController.getTransactionByUuid(
        widget.transaction.uuid,
      );

      if (latestTransaction != null) {
        // ในกรณีที่ edit
        _nameController.text = latestTransaction.name;
        _descController.text = latestTransaction.desc;
        _amountController.text = latestTransaction.amount.toString();
        _type = latestTransaction.type;
        _selectedDate = DateTime.tryParse(latestTransaction.date);
      } else {
        // fallback กรณีไม่พบใน controller
        _nameController.text = widget.transaction.name;
        _descController.text = widget.transaction.desc;
        _amountController.text = widget.transaction.amount.toString();
        _type = widget.transaction.type;
        _selectedDate = DateTime.tryParse(widget.transaction.date);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40),

            Text(
              widget.transaction != null
                  ? 'แก้ไขข้อมูลการทำรายการ'
                  : 'บันทึกข้อมูลการทำรายการ',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'ชื่อรายการ'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'กรุณากรอกชื่อรายการ' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'รายละเอียด'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'กรุณากรอกรายละเอียด' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'จำนวนเงิน'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value == null || value.isEmpty ? 'กรุณากรอกจำนวนเงิน' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: _type,
              decoration: const InputDecoration(labelText: 'ประเภท'),
              items: const [
                DropdownMenuItem(value: 1, child: Text('รายรับ')),
                DropdownMenuItem(value: -1, child: Text('รายจ่าย')),
              ],
              onChanged: (value) {
                setState(() {
                  _type = value ?? -1;
                });
              },
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'กรุณาเลือกวันที่'
                        : 'วันที่: ${_selectedDate!.toIso8601String().substring(0, 10)}',
                  ),
                ),
                TextButton(
                  onPressed: _pickDate,
                  child: const Text('เลือกวันที่'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.transaction != null
                        ? _submitUpdateForm()
                        : _submitCreateForm();
                  }, //_submitForm,
                  child: const Text('บันทึกข้อมูล'),
                ),
                widget.transaction != null
                    ? const SizedBox(width: 16)
                    : Container(),
                widget.transaction != null
                    ? ElevatedButton(
                        onPressed: () {
                          _submitDeleteForm();
                        },
                        child: Text('ลบข้อมูล'),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
