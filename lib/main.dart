import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneytracker/model/transaction.dart';
import 'package:moneytracker/widgets/chart.dart';
import 'package:moneytracker/widgets/new_tarnsaction.dart';
import 'package:moneytracker/widgets/transaction_list.dart';
import 'dart:io';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
//
//  });
  runApp(MyApp());
}

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
  bool _showChart = false;

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
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Money Tracker"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () {
                    showBtSheet(context);
                  },
                )
              ],
            ),
          )
        : AppBar(
            title: Text("Money Tracker"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  showBtSheet(context);
                },
              )
            ],
          );

    final pageBody = SingleChildScrollView(
        child: Column(
      children: <Widget>[
        if (isLandscape)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Show Chart"),
              Switch.adaptive(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  }),
            ],
          ),
        if (isLandscape)
          _showChart
              ? Container(
                  height: (mediaQuery.size.height * 0.7) -
                      mediaQuery.padding.top -
                      appBar.preferredSize.height,
                  child: Chart(_recentTransaction))
              : Container(
                  height: (mediaQuery.size.height * 0.7) -
                      mediaQuery.padding.top -
                      appBar.preferredSize.height,
                  child: Transactionlist(_userTransaction, _deleteTransaction)),
        if (!isLandscape)
          Container(
              height: (mediaQuery.size.height * 0.35) -
                  mediaQuery.padding.top -
                  appBar.preferredSize.height,
              child: Chart(_recentTransaction)),
        if (!isLandscape)
          Container(
              height: (mediaQuery.size.height * 0.7) -
                  mediaQuery.padding.top -
                  appBar.preferredSize.height,
              child: Transactionlist(_userTransaction, _deleteTransaction)),
      ],
    ));
    return Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showBtSheet(context);
              },
            ),
    );
  }
}
