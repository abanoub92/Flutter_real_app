import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    //set the size of widgets depend on the parent size that giving by layoutBuilder
    return LayoutBuilder(builder: (ctx, constraints){
      return Column(
        children: <Widget>[
          //Creates a widget that scales and positions it's child with it self according to fit.
          //if it widget is a text it's shrink the text
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05,),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            //Stack is a widget take array of values of widgets overlabing each other
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05,),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text(label))
          ),
        ],
      );
    },); 
  }
}