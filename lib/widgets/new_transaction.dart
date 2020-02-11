import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = new TextEditingController();

  final amountController = new TextEditingController();

  void _submitData() {
    String title = titleController.text;
    double amount = double.parse(amountController.text);
    if (title.isEmpty || amount <= 0) {
      return;
    }
    widget.addTx(title, amount);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Enter Product name"),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Enter Product amount"),
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            RaisedButton(
              child: Text(
                "Add Product",
              ),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: _submitData,
            )
          ],
        ),
      ),
    );
  }
}
