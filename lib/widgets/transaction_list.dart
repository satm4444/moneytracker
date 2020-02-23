import 'package:flutter/material.dart';
import 'package:moneytracker/model/transaction.dart';

class Transactionlist extends StatelessWidget {

  final List<Transaction> _transactions;
  Transactionlist(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      child: ListView.builder(itemCount:_transactions.length ,itemBuilder: (Ctx,i){
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              radius: 30,
              child: Text(_transactions[i].price.toString(),style: TextStyle(
                color: Colors.white,
                  fontWeight: FontWeight.bold,fontSize: 14
              ),),
            ),
            title: Text(_transactions[i].title,style: Theme.of(context).textTheme.title,

            ),
            subtitle: Text(_transactions[i].dateTime.toString(),style: TextStyle(
              fontWeight: FontWeight.bold,fontSize: 19,
            ),),
          ),
        );
      }),
    );
  }
}
