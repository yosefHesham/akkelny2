import 'package:akkelny3/bloc/auth_repo.dart';
import 'package:akkelny3/bloc/authbloc_bloc.dart';
import 'package:akkelny3/screens/auth_screen.dart';
import 'package:akkelny3/screens/home_screen.dart';
import 'package:akkelny3/screens/intro_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: non_constant_identifier_names
  final check_intro = await checkIntro();
  await Firebase.initializeApp();
  runApp(MyApp(check_intro));
}

class MyApp extends StatelessWidget {
  final checkIntro;
  MyApp(this.checkIntro);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(AuthRepo()),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.deepOrange),
          home: checkIntro
              ? BlocBuilder<AuthBloc, AuthblocState>(builder: (context, state) {
                  return state is SignedInState ? HomeScreen() : AuthScreen();
                })
              : IntroPage(),
          routes: {AuthScreen.routeName: (context) => AuthScreen()}),
    );
  }
}

Future<bool> checkIntro() async {
  final shared = await SharedPreferences.getInstance();
  final isDone = shared.getBool("intro");
  if (isDone != null) {
    return isDone;
  }
  return false;
}
