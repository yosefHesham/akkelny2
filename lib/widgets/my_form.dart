import 'package:akkelny3/bloc/authbloc_bloc.dart';
import 'package:akkelny3/bloc/bloc/form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String mail;
  String password;
  final _mailFocusNode = FocusNode();
  final _paswordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocListener<FormBloc, FormValidate>(
        listener: (ctx, state) {
          if (state is SubmitFormState) {
            _submitForm(state.isSignup);
          }
        },
        child: Container(
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
                              onSaved: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                              validator: (v) {
                                if (v.isEmpty || v.trim().isEmpty) {
                                  return "User name Cannot be empty !";
                                }
                                if (v.length < 5) {
                                  return "Short user name !";
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_mailFocusNode);
                              },
                              decoration: InputDecoration(
                                  hintText: "User Name",
                                  suffixIcon:
                                      Icon(Icons.supervised_user_circle)),
                            ),
                          )
                        : Container();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    onSaved: (value) {
                      setState(() {
                        mail = value;
                      });
                    },
                    focusNode: _mailFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_paswordFocusNode);
                    },
                    validator: (v) {
                      if (v.isEmpty || v.trim().isEmpty) {
                        return "Mail Cannot Be Empty !";
                      }
                      if (!v.contains("@") || !v.endsWith(".com")) {
                        return "Invalid mail !";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "mail", suffixIcon: Icon(Icons.mail)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    focusNode: _paswordFocusNode,
                    onSaved: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    validator: (v) {
                      if (v.isEmpty || v.trim().isEmpty) {
                        return "Password Cannot Be Empty !";
                      }
                      if (v.length < 8) {
                        return "Short Pasword !";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Password", suffixIcon: Icon(Icons.lock)),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _submitForm(bool isSignUp) {
    if (_formKey.currentState.validate()) {
      setState(() {
        _formKey.currentState.save();
      });
      if (isSignUp) {
        BlocProvider.of<AuthBloc>(context)
            .add(SignUpEvent(name: name, email: mail, password: password));
      } else {
        BlocProvider.of<AuthBloc>(context)
            .add(SignInEvent(email: mail, password: password));
      }
    }
  }
}
