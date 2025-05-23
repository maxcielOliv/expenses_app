import 'package:despesas_app/app/components/chart_bar.dart';
import 'package:despesas_app/app/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentTransaction});

  final List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );

        final acronym = DateFormat.E().format(weekDay)[0];

        double sum = 0.0;

        for (var i = 0; i < recentTransaction.length; i++) {
          bool sameDay = recentTransaction[i].date.day == weekDay.day;
          bool sameMonth = recentTransaction[i].date.month == weekDay.month;
          bool sameYear = recentTransaction[i].date.year == weekDay.year;

          if (sameDay && sameMonth && sameYear) {
            sum += recentTransaction[i].value;
          }
        }
        return {
          'day': acronym,
          'value': sum,
        };
      },
    ).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactions.map(
              (tr) {
                return Expanded(
                  child: ChartBar(
                    label: '${tr['day']}',
                    value: (tr['value'] as double),
                    percentage: _weekTotalValue == 0
                        ? 0
                        : (tr['value'] as double) / _weekTotalValue,
                  ),
                );
              },
            ).toList()),
      ),
    );
  }
}
