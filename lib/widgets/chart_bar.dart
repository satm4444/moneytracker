import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double price;
  final String day;
  final double pricePercent;

  ChartBar(this.price, this.day, this.pricePercent);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, contraints) {
        return Column(
          children: <Widget>[
            Container(
                height: contraints.maxHeight * 0.15,
                child: FittedBox(child: Text("\$$price"))),
            SizedBox(
              height: contraints.maxHeight * 0.05,
            ),
            Container(
              height: contraints.maxHeight * 0.6,
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
              height: contraints.maxHeight * 0.05,
            ),
            Container(height: contraints.maxHeight * 0.15, child: Text(day)),
          ],
        );
      },
    );
  }
}
