import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_real_app/models/transactions.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget{

  final List<Transactions> recentlyTransactions;

  Chart(this.recentlyTransactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (int i = 0; i < recentlyTransactions.length; i++){
        if (recentlyTransactions[i].date.day == weekDay.day 
            && recentlyTransactions[i].date.month == weekDay.month
            && recentlyTransactions[i].date.year == weekDay.year){
              totalSum += recentlyTransactions[i].amount;
        }
      }

      return {'Day': DateFormat.E(weekDay), 'amount': totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[

        ],
      ),
    );
  }
}