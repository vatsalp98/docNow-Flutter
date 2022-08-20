import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:docnow/helpers/bottom_navigation_dash.dart';
import 'package:docnow/helpers/configure_amplify.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureAmplify();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Authenticator(
      preferPrivateSession: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doc Now',
        builder: Authenticator.builder(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData.dark(),
        home: Dashboard(),
      ),
    );
  }
}
