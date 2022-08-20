import 'package:flutter/material.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = 'settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Settings',
            style: TextStyle(
              color: Colors.teal[400],
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              leading: Icon(Icons.person_rounded),
              title: Text('Mon Profile'),
              trailing: Icon(Icons.keyboard_arrow_right_rounded),
            ),
            Divider(
              indent: 15,
              endIndent: 15,
              height: 1,
              color: Theme.of(context).primaryColor,
            ),
            Center(
              child: SignOutButton(),
            ),
          ],
        ),
      ),
    );
  }
}
