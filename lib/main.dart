import 'package:flutter/material.dart';
import 'package:flutter_real_app/widgets/chart.dart';
import 'package:flutter_real_app/widgets/new_transactions.dart';
import './widgets/transaction_list.dart';
import './models/transactions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        //create a specific style to all text widgets in the app
        textTheme: ThemeData.light().textTheme.copyWith(
          headline: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle( color: Colors.white,),
          
        ),
        //create a specific style to specific widget
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
          )
        )
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //String titleText;   //use this option with onChange: method in TextField()
  //String amountText;  //use this option with onChange: method in TextField()

  final List<Transactions> _list = [
    Transactions(
      id: 't1',
      title: 'new shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transactions(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.54,
      date: DateTime.now(),
    ),
  ];

  //get the recent transactions only that happend in this week
  List<Transactions> get recentTransactions{
    return _list.where((transactions) {
      return transactions.date.isAfter(
        DateTime.now().subtract(Duration(days: 7),)
      );
    }).toList();
  }

  void _createNewTransaction(String title, double amount, DateTime selectedDate){
    final Transactions transaction = Transactions(
      id: DateTime.now().toString(), 
      title: title, 
      amount: amount, 
      date: selectedDate,
    );

    setState(() {
      _list.add(transaction);
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _list.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext context){
    showModalBottomSheet(context: context, builder: (_){   //_ means unwanted parameter (context)
        return NewTransactions(_createNewTransaction);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Real App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: (){
              _startAddNewTransaction(context);
            }
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Chart(recentTransactions),
            TransactionList(_list, _deleteTransaction),
          ],
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), 
        onPressed: (){
          _startAddNewTransaction(context);
        }
        ),
    );
  }
}
