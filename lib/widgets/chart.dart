import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';
import './chart_bar.dart';

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

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1), 
        'amount': totalSum
      };
    }); //.reversed.toList(); is resvere the list data items
  }

   double get totalSpending{
    return groupedTransactionsValues.fold(0.0, (sum, item){
        return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionsValues.map((data){
          //creates a widget that controls how a child of a (row, column or flex) flexs 
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              data['day'], 
              data['amount'], 
              totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending
            ),
          );
        }).toList(),
      ),
    );
  }
}