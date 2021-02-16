import 'package:akkelny3/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthButton extends StatelessWidget {
  final String buttonCaption;
  final Function onPress;
  AuthButton(this.buttonCaption, this.onPress);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onPress(),
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.height * .06,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [firstColor, secondColor])),
          child: Center(
            child: Text(
              buttonCaption,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ));
  }
}
