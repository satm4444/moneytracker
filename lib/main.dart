import 'package:flutter/material.dart';
import 'package:moneytracker/model/transaction.dart';
import 'package:moneytracker/widgets/new_tarnsaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Money Tracker",
      home: MoneyTrackPage(),
    );
  }
}

class MoneyTrackPage extends StatefulWidget {
  @override
  _MoneyTrackPageState createState() => _MoneyTrackPageState();
}

class _MoneyTrackPageState extends State<MoneyTrackPage> {
  List<Transaction> _userTransaction = [
    Transaction(title: "Watch", price:2000,dateTime: DateTime.now() ),
    Transaction(title: "Car", price:7000,dateTime: DateTime.now() ),
    Transaction(title: "Phone", price:1000,dateTime: DateTime.now() ),
  ];

  void _addTransaction(String txTitle, double txPrice){
    Transaction newTx =new Transaction(title: txTitle, price: txPrice, dateTime: DateTime.now());
    setState(() {
      _userTransaction.add(newTx);
    });

  }

  void showBtSheet(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (bCtx){
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
            icon:Icon(Icons.add),
            onPressed: (){
              showBtSheet(context);
            },
          )

        ],
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Container(
              width:double.infinity,
              child: Text("Chart"),
            ),
          ),

          Column(
            children: _userTransaction.map((tx){
             return Card(
               child: ListTile(
                 leading: CircleAvatar(
                   backgroundColor: Colors.green,
                   radius: 30,
                   child: Text(tx.price.toString(),style: TextStyle(
                     fontWeight: FontWeight.bold,fontSize: 14
                   ),),
                 ),
                 title: Text(tx.title,style: TextStyle(
                   fontWeight: FontWeight.bold,fontSize: 19,
                 ),),
                 subtitle: Text(tx.dateTime.toString(),style: TextStyle(
                   fontWeight: FontWeight.bold,fontSize: 19,
                 ),),
               ),
             );
            }).toList(),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          showBtSheet(context);
        },
      ),
    );
  }
}
