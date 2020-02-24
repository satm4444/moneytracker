import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:moneytracker/widgets/adaptive_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = new TextEditingController();

  final amountController = new TextEditingController();
  DateTime selectedDate;
  void addToTransaction() {
    String title = titleController.text;
    double price = double.parse(amountController.text);

    if (title.isEmpty || price < 0 || selectedDate == null) {
      return;
    }

    widget.addTx(title, price, selectedDate);
    Navigator.of(context).pop();
  }

  void showDate(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
              left: 10.0,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Enter the title"),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Enter the amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    selectedDate == null
                        ? "No date selected"
                        : "PickedDate:${selectedDate.toString()}",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  AdaptiveButton(
                    onPress: () {
                      showDate(context);
                    },
                    text: "Choose date",
                  )
                ],
              ),
              RaisedButton(
                color: Colors.green,
                child: Text(
                  "Add transaction",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.white),
                ),
                onPressed: () {
                  addToTransaction();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
