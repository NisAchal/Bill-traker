import 'package:bill_traker/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No transactions has been added",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(fontFamily: "Mont"),
                ),
                SizedBox(
                  height: 5,
                ),
                Image.asset("assets/images/box.png"),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).accentColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                            "\$${transactions[index].amount.toString()}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(transactions[index].date),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
//child: Row(
//children: <Widget>[
//Container(
//child: Text(
//"\$${transactions[index].amount.toString()}",
//style: TextStyle(
//color: Theme.of(context).accentColor,
//fontSize: 24,
//fontWeight: FontWeight.bold),
//),
//decoration: BoxDecoration(
//border: Border.all(
//color: Theme.of(context).accentColor,
//width: 2,
//),
//borderRadius: BorderRadius.circular(5)),
//margin: EdgeInsets.all(5),
//padding: EdgeInsets.all(5),
//),
//SizedBox(
//width: 20,
//),
//Column(
//crossAxisAlignment: CrossAxisAlignment.start,
//children: <Widget>[
//Text(
//transactions[index].title,
//style: Theme.of(context).textTheme.title.copyWith(
//color: Colors.grey,
//fontWeight: FontWeight.bold),
////                      TextStyle(
////                        fontWeight: FontWeight.bold,
////                        fontSize: 18,
////                      ),
//),

//),
//),
//],
//)
//],
//),
