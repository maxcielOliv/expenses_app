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
  bool _showchart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
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

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
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
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: const Text(
        'Despesas Pessoais',
      ),
      actions: [
        if (isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _showchart = !_showchart;
              });
            },
            icon: Icon(_showchart ? Icons.list : Icons.show_chart),
          ),
        IconButton(
          onPressed: () => openTransactionFormModal(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showchart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 0.7 : 0.3),
                child: Chart(recentTransaction: _recentTransactions),
              ),
            if (!_showchart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(
                  transactions: _transactions,
                  onRemove: _removeTransaction,
                ),
              ),
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
