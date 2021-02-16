import 'package:akkelny3/bloc/authbloc_bloc.dart';
import 'package:akkelny3/public.dart';
import 'package:akkelny3/widgets/auth_button.dart';
import 'package:akkelny3/widgets/my_form.dart';
import 'package:akkelny3/widgets/sm_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      body: BlocListener<AuthBloc, AuthblocState>(
        listener: (ctx, state) {
          if (state is AuthErrorState) {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              duration: Duration(seconds: 2),
              content: Text(state.errorMsg),
              backgroundColor: firstColor.withOpacity(.5),
            ));
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * .1),
              BlocBuilder<AuthBloc, AuthblocState>(
                builder: (context, state) {
                  return Text(
                    state is SignInState || state is AuthblocInitial
                        ? 'Sign In'
                        : 'Sign Up',
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  );
                },
              ),
              SizedBox(height: size.height * .02),
              Text(
                'Or Continue With Your Social Netowrks',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
              SizedBox(height: size.height * .05),
              smAuth(),
              SizedBox(height: size.height * .05),
              MyForm(),
              SizedBox(
                height: size.height * .05,
              ),
              BlocBuilder<AuthBloc, AuthblocState>(builder: (context, state) {
                if (state is SwitchToSignUp) {
                  return AuthButton("Sign Up", () => null);
                } else if (state is SignInState) {
                  return AuthButton("Sign In", () => null);
                }
                return AuthButton("Sign In", () => null);
              }),
              SizedBox(height: size.height * .04),
              BlocBuilder<AuthBloc, AuthblocState>(builder: (context, state) {
                return state is SwitchToSignUp
                    ? Container()
                    : AuthButton("Sign Up", _switchToSignUp);
              }),
              BlocBuilder<AuthBloc, AuthblocState>(
                builder: (context, state) {
                  return state is SwitchToSignUp
                      ? TextButton(
                          onPressed: () => addEvent(SwitchToSignInEvent()),
                          child: Text("Already registred! Sign In "))
                      : Container();
                },
              )
            ],
          ),
        ),
      ),
    ));
  }

  _switchToSignUp() => addEvent(SwitchToSignUpEvent());

  Widget smAuth() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Spacer(),
      Expanded(flex: 3, child: SmButton(FontAwesomeIcons.facebook, "Facebook")),
      Spacer(),
      Expanded(
          flex: 3,
          child: BlocBuilder<AuthBloc, AuthblocState>(
            builder: (context, state) {
              return state is AuthLoadingState
                  ? progressIndicator()
                  : SmButton(FontAwesomeIcons.google, "Google");
            },
          )),
      Spacer()
    ]);
  }

  Center progressIndicator() => Center(
        child: CircularProgressIndicator(),
      );

  /// addEvent

  void addEvent(AuthblocEvent event) {
    BlocProvider.of<AuthBloc>(context, listen: false).add(event);
  }
}
