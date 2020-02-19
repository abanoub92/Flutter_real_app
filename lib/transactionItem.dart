import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transactions.dart';

class TransactionItem extends StatelessWidget {

  final Transactions data;

  TransactionItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            decoration: BoxDecoration(border: Border.all(color: Colors.purple, width: 2,)),
            child: Text(
              '\$${data.amount}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.purple),
            ),
            padding: EdgeInsets.all(10),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                data.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                DateFormat("yyyy/MM/dd").format(data.date),
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
