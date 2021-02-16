import 'package:akkelny3/bloc/authbloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            BlocBuilder<AuthBloc, AuthblocState>(
              builder: (context, state) {
                return state is SwitchToSignUp
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "User Name",
                              suffixIcon: Icon(Icons.supervised_user_circle)),
                        ),
                      )
                    : Container();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "mail", suffixIcon: Icon(Icons.mail)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Password", suffixIcon: Icon(Icons.lock)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
