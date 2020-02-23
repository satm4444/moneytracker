import 'package:flutter/material.dart';
import 'package:moneytracker/model/transaction.dart';
import 'package:moneytracker/widgets/chart.dart';
import 'package:moneytracker/widgets/new_tarnsaction.dart';
import 'package:moneytracker/widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Money Tracker",
      home: MoneyTrackPage(),
      theme: ThemeData(
          primaryColor: Colors.brown,
          accentColor: Colors.green,
          fontFamily: "Comfortaa",
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  title: TextStyle(
                      fontFamily: "Caveat",
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold))),
          textTheme: TextTheme(
            title: TextStyle(fontFamily: "Caveat"),
          )),
    );
  }
}

class MoneyTrackPage extends StatefulWidget {
  @override
  _MoneyTrackPageState createState() => _MoneyTrackPageState();
}

class _MoneyTrackPageState extends State<MoneyTrackPage> {
  List<Transaction> _userTransaction = [];

  void _addTransaction(String txTitle, double txPrice, DateTime txDate) {
    Transaction newTx = new Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        price: txPrice,
        dateTime: txDate);
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void showBtSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Money Tracker"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showBtSheet(context);
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Chart(_recentTransaction),
          Transactionlist(_userTransaction, _deleteTransaction),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showBtSheet(context);
        },
      ),
    );
  }
}
