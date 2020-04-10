import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  var _selectedDate;

  void validateData(){
    final titleValue = textController.text;
    double amountValue;
    if (amountController.text.isNotEmpty)
      amountValue = double.parse(amountController.text);

    if (titleValue.isEmpty || amountValue <= 0 || _selectedDate == null){
      return;
    }

    widget.newData(titleValue, amountValue, _selectedDate);    //widget is a proparty in state class make us access to stateful class methods and proparties

    Navigator.of(context).pop();  //to close bottomModalSheet
  }

  void getDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020), 
      lastDate: DateTime.now(),
    ).then((pickedDate){
      if (pickedDate == null)
        return;

        setState(() {
          _selectedDate = pickedDate;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: double.infinity,
      padding: EdgeInsets.all(16),
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
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null ? 'No date chosen.' : 'Chosen Date: ${DateFormat.yMMMd().format(_selectedDate)}'),
                  ),
                  FlatButton(
                    onPressed: getDatePicker, 
                    child: Text('Choose Date', style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),),
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: validateData,
              color: Theme.of(context).primaryColor,
              child: Text("Add Transaction", style: TextStyle(color: Theme.of(context).textTheme.button.color),), 
            )
          ],
        ),
    );
  }
}