import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final Color textColor;

  SocialButton({this.text, this.textColor});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 120.0,
      height: 40.0,
      child: RaisedButton(
        onPressed: () {},
        color: Theme.of(context).primaryColor,
        textColor: textColor,
        child: Text(text, textAlign: TextAlign.center,),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }
}
