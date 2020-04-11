import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

class TransactionList extends StatelessWidget{

  final List<Transactions> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? LayoutBuilder(builder: (ctx, constraints){
      return Column(
        children: <Widget>[
          Text("No transactions added yet!", style: Theme.of(context).textTheme.headline,),
          //use SizedBox as aparent layout has (height, width) or a separate transparent space
          SizedBox(
            height: 10,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            child: Image.asset("assets/images/waiting.png", fit: BoxFit.cover,),
          )
        ],
      );
    },) : ListView.builder(
      itemBuilder: (context, index){
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8,),
          child: Padding(
            padding: EdgeInsets.all(4),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: FittedBox(
                  child: Text('\$${transactions.elementAt(index).amount.toStringAsFixed(0)}'),
                ),
              ),
              title: Text(
                transactions.elementAt(index).title, 
                style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions.elementAt(index).date),
              ),
              trailing: MediaQuery.of(context).size.width > 450 ?
              FlatButton.icon(
                onPressed: () => deleteTx(transactions.elementAt(index).id), 
                icon: Icon(Icons.delete, color: Theme.of(context).errorColor,), 
                label: Text('Delete', style: TextStyle(color: Theme.of(context).errorColor,),)
              )
              :
              IconButton(
                icon: Icon(Icons.delete, color: Theme.of(context).errorColor,), 
                onPressed: (){
                  deleteTx(transactions.elementAt(index).id);
                },
              ),
            ),
          ),
        );
      },
      itemCount: transactions.length,
    );
  }

}