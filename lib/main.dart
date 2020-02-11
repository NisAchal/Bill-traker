import 'package:bill_traker/model/transaction.dart';
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

  void addTransaction(String txTitle, double txAmount) {
    final newTx =
        Transaction(title: txTitle, amount: txAmount, date: DateTime.now());
    setState(() {
      userTranaction.add(newTx);
    });
  }

  List<Transaction> userTranaction = [
    Transaction(title: "Groceries", amount: 50.00, date: DateTime.now()),
    Transaction(title: "Watch", amount: 50.00, date: DateTime.now()),
    Transaction(title: "shoes", amount: 50.00, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track your bills!"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text("Chart"),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                      decoration:
                          InputDecoration(labelText: "Enter Product name"),
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                    TextField(
                      decoration:
                          InputDecoration(labelText: "Enter Product amount"),
                      onChanged: (value) {
                        amount = double.parse(value);
                      },
                      keyboardType: TextInputType.number,
                    ),
                    RaisedButton(
                      child: Text(
                        "Add Product",
                      ),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                        addTransaction(title, amount);
                      },
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: userTranaction.map((tx) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "\$${tx.amount.toString()}",
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tx.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMEd().format(tx.date),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
