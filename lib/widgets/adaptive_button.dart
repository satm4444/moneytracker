import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final Function onPress;

  AdaptiveButton({this.onPress, this.text});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPress,
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontSize: 16, color: Theme.of(context).accentColor),
            ),
          )
        : FlatButton(
            onPressed: onPress,
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontSize: 16, color: Theme.of(context).accentColor),
            ),
          );
  }
}
