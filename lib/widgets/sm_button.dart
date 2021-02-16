import 'package:akkelny3/bloc/authbloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SmButton extends StatelessWidget {
  final IconData icon;
  final String smName;

  SmButton(this.icon, this.smName);
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 5,
      child: Container(
        height: MediaQuery.of(context).size.height * .06,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          onTap: () => BlocProvider.of<AuthBloc>(context).add(
              icon == FontAwesomeIcons.facebook ? null : GoogleSignInEvent()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(),
              FaIcon(
                icon,
                size: 30,
                color: icon == FontAwesomeIcons.facebook
                    ? Colors.blue.withOpacity(1)
                    : Colors.red,
              ),
              Spacer(),
              Text(
                smName,
                style: TextStyle(fontSize: 18, color: Colors.black45),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
