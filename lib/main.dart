import 'package:bill_traker/model/transaction.dart';
import 'package:bill_traker/widgets/chart.dart';
import 'package:bill_traker/widgets/new_transaction.dart';
import 'package:bill_traker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bill Traker',
      home: BillPage(),
      theme: ThemeData(
        primaryColor: Colors.brown,
        accentColor: Colors.green,
        textTheme: TextTheme(
          title: TextStyle(
              fontFamily: "Lato", fontSize: 18, fontWeight: FontWeight.bold),
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(
              fontFamily: "Lato",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  String title;
  double amount;

  List<Transaction> get _recentTransaction {
    return _userTranaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String txTitle, double txAmount) {
    final newTx =
        Transaction(title: txTitle, amount: txAmount, date: DateTime.now());
    setState(() {
      _userTranaction.add(newTx);
    });
  }

  List<Transaction> _userTranaction = [
    Transaction(title: "Groceries", amount: 50.00, date: DateTime.now()),
    Transaction(title: "Watch", amount: 50.00, date: DateTime.now()),
    Transaction(title: "shoes", amount: 50.00, date: DateTime.now()),
  ];

  void _showAddTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return NewTransaction(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track your bills!"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => _showAddTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Chart(_recentTransaction),
            //  NewTransaction(_addTransaction),
            TransactionList(_userTranaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddTransaction(context),
      ),
    );
  }
}
