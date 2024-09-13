import 'dart:math';
import 'package:despesas_app/app/components/chart.dart';
import 'package:despesas_app/app/components/transaction_form.dart';
import 'package:despesas_app/app/components/transaction_list.dart';
import 'package:despesas_app/app/models/transaction.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(
      () {
        _transactions.add(newTransaction);
      },
    );

    Navigator.pop(context);
  }

  openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(
          onSubmit: addTransaction,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Despesas Pessoais',
        ),
        actions: [
          IconButton(
            onPressed: () => openTransactionFormModal(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Chart(recentTransaction: _recentTransactions),
            TransactionList(transactions: _transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openTransactionFormModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
