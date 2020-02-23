import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double price;
  final String day;
  final double pricePercent;

  ChartBar(this.price, this.day, this.pricePercent);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 15, child: FittedBox(child: Text("\$$price"))),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey, width: 1.0)),
              ),
              FractionallySizedBox(
                heightFactor: pricePercent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(day),
      ],
    );
  }
}
