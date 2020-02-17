import 'dart:io';

import 'package:bill_traker/model/transaction.dart';
import 'package:bill_traker/widgets/chart.dart';
import 'package:bill_traker/widgets/new_transaction.dart';
import 'package:bill_traker/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:intl/intl.dart';

void main() {
  /*
  -----this method ensure only to use portrait mode-----------
   */
//  WidgetsFlutterBinding.ensureInitialized();
//
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
//
//  });
  runApp(MyApp());
}

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
  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _userTranaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: txDate,
        id: DateTime.now().toString());
    setState(() {
      _userTranaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTranaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  List<Transaction> _userTranaction = [
//    Transaction(title: "Groceries", amount: 50.00, date: DateTime.now()),
//    Transaction(title: "Watch", amount: 50.00, date: DateTime.now()),
//    Transaction(title: "shoes", amount: 50.00, date: DateTime.now()),
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
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Track your bills!"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    CupertinoIcons.add,
                    color: Colors.white,
                  ),
                  onTap: () => _showAddTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
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
          );
    final txListWidget = Container(
        height: (mediaQuery.size.height * 0.7) -
            appBar.preferredSize.height -
            mediaQuery.padding.top,
        child: TransactionList(_userTranaction, _deleteTransaction));
    final pageBody = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Show Chart"),
                Switch.adaptive(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                )
              ],
            ),
          if (!isLandscape)
            Container(
                height: (mediaQuery.size.height * 0.3) -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top,
                child: Chart(_recentTransaction)),
          if (!isLandscape) txListWidget,
          if (isLandscape)
            _showChart
                ? Container(
                    height: (mediaQuery.size.height * 0.7) -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top,
                    child: Chart(_recentTransaction))
                //  NewTransaction(_addTransaction),
                : txListWidget,
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _showAddTransaction(context),
                  ),
          );
  }
}
