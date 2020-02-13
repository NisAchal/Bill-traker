import 'package:bill_traker/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;
  Chart(this._recentTransactions);

  List<Map<String, Object>> get groupedExpenses {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (int i = 0; i < _recentTransactions.length; i++) {
        if (_recentTransactions[i].date.day == weekDay.day &&
            _recentTransactions[i].date.month == weekDay.month &&
            _recentTransactions[i].date.year == weekDay.year) {
          totalSum += _recentTransactions[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get totalSpendAmount {
    return groupedExpenses.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: groupedExpenses.map((tx) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              day: tx['day'],
              spendAmount: tx['amount'],
              spendPercent: totalSpendAmount == 0.0
                  ? 0.0
                  : (tx['amount'] as double) / totalSpendAmount,
            ),
          );
        }).toList(),
      ),
    ));
  }
}
