import 'package:flutter/material.dart';

class NewTransactions extends StatefulWidget {

  final Function newData;

  NewTransactions(this.newData);

  @override
  State<StatefulWidget> createState() {
    return NewTransactionsState();
  }

}

class NewTransactionsState extends State<NewTransactions>{

  final textController = TextEditingController();
  final amountController = TextEditingController();

  void validateData(){
    final titleValue = textController.text;
    double amountValue;
    if (amountController.text.isNotEmpty)
      amountValue = double.parse(amountController.text);

    if (titleValue.isEmpty || amountValue <= 0){
      return;
    }

    widget.newData(titleValue, amountValue);    //widget is a proparty in state class make us access to stateful class methods and proparties

    Navigator.of(context).pop();  //to close bottomModalSheet
  }

  @override
  Widget build(BuildContext context) {
    return Container(
              //width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: "Title"), 
                      //onChanged: (title){ titleText = title; },
                      controller: textController,
                      onSubmitted: (_) => validateData(),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: "Amount"), 
                      //onChanged: (amount) => amountText = amount,
                      controller: amountController,
                      onSubmitted: (_) => validateData(),
                    ),
                    FlatButton(
                      onPressed: validateData, 
                      child: Text("Add Transaction"), textColor: Theme.of(context).primaryColor,)
                  ],
                ),
              ),
            );
  }
}