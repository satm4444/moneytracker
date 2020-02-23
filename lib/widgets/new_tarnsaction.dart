import 'package:flutter/material.dart';
class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController =  new TextEditingController();

  final amountController = new TextEditingController();

  void addToTransaction(){
    String title = titleController.text;
    double price = double.parse(amountController.text);

    if(title.isEmpty || price<0){
      return;
    }

    widget.addTx(title,price);
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: "Enter the title"
              ),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Enter the amount"
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            RaisedButton(
              color: Colors.green,
              child: Text("Add transaction", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:13,
                  color: Colors.white
              ),),
              onPressed: (){
                addToTransaction();
              },
            ),
          ],
        ),
      ),
    );
  }
}
