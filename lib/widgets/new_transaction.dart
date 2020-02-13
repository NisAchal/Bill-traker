import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = new TextEditingController();
  final amountController = new TextEditingController();
  DateTime _selectedDateTime;

  void _submitData() {
    String title = titleController.text;
    double amount = double.parse(amountController.text);
    if (title.isEmpty || amount <= 0 || _selectedDateTime == null) {
      return;
    }
    widget.addTx(title, amount, _selectedDateTime);
    Navigator.pop(context);
  }

  void _pickDate(BuildContext ctx) {
    showDatePicker(
            context: ctx,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickDate) {
      setState(() {
        _selectedDateTime = pickDate;
      });
    });
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _selectedDateTime == null
                      ? "No date chosen"
                      : "picked Date ${DateFormat.yMd().format(_selectedDateTime).toString()}",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    "Choose a date",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontFamily: "Mont"),
                  ),
                  onPressed: () => _pickDate(context),
                )
              ],
            ),
            RaisedButton(
              child: Text(
                "Add Product",
              ),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              onPressed: _submitData,
            )
          ],
        ),
      ),
    );
  }
}
