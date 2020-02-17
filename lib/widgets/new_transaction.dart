//import 'dart:io';

import 'package:bill_traker/widgets/adaptive_button.dart';
import 'package:flutter/cupertino.dart';
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

  void _pickDate() {
    showDatePicker(
            context: context,
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
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                  decoration: InputDecoration(labelText: "Enter Product name"),
                  controller: titleController,
                  onSubmitted: (_) {
                    _submitData();
                  }),
              TextField(
                decoration: InputDecoration(labelText: "Enter Product amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) {
                  _submitData();
                },
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
                  AdaptiveButton(
                    onPress: _pickDate,
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
      ),
    );
  }
}
