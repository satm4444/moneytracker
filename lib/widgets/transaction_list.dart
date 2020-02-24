import 'package:flutter/material.dart';
import 'package:moneytracker/model/transaction.dart';

class Transactionlist extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTx;

  Transactionlist(this._transactions, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    "No Transaction ahve been added",
                    style: Theme.of(context).textTheme.title,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.7,
                    child: Image.asset(
                      "assets/images/box.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (Ctx, i) {
              return Card(
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: FittedBox(
                          child: Text(
                            _transactions[i].price.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      _transactions[i].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      _transactions[i].dateTime.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        _deleteTx(_transactions[i].id);
                      },
                    )),
              );
            });
  }
}
