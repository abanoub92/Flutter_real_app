import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

class TransactionList extends StatelessWidget{

  final List<Transactions> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: transactions.isEmpty ? Column(
        children: <Widget>[
          Text("No transactions added yet!", style: Theme.of(context).textTheme.headline,),
          //use SizedBox as aparent layout has (height, width) or a separate transparent space
          SizedBox(
            height: 10,
          ),
          Container(
            height: 200,
            child: Image.asset("assets/images/waiting.png", fit: BoxFit.cover,),
          )
        ],
      ) : ListView.builder(
      itemBuilder: (context, index){
        return Card(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                )),
                child: Text(
                  '\$${transactions[index].amount.toStringAsFixed(2)}', //decimel numbers after comma
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor
                      ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transactions[index].title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    DateFormat("yyyy/MM/dd").format(transactions[index].date),
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
        );
      },
      itemCount: transactions.length,
    ),
    );
  }

}
