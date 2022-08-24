import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:docnow/screens/activeHours_screen.dart';
import 'package:flutter/material.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_of_year/week_of_year.dart';

import '../bloc/schedule_bloc/schedule_bloc.dart';

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
            ListTile(
              leading: Icon(Icons.person_rounded),
              title: Text('Mon Profile'),
              trailing: Icon(Icons.keyboard_arrow_right_rounded),
            ),
            Divider(
              indent: 15,
              endIndent: 15,
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.language_rounded),
              title: Text('Languages'),
              trailing: Icon(Icons.keyboard_arrow_right_rounded),
            ),
            Divider(
              indent: 15,
              endIndent: 15,
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.hourglass_full_rounded),
              title: Text('Active Hours'),
              onTap: () async {
                final user = await Amplify.Auth.getCurrentUser();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return BlocProvider(
                        create: (context) => ScheduleBloc(),
                        child: ActiveHourScreen(
                          user_id: user.userId,
                          scheduleBloc: ScheduleBloc(),
                          weekNumber: DateTime.now().weekOfYear,
                        ),
                      );
                    },
                  ),
                );
              },
              trailing: Icon(Icons.keyboard_arrow_right_rounded),
            ),
            Divider(
              indent: 15,
              endIndent: 15,
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.help_center_rounded),
              title: Text('Help & Support'),
              trailing: Icon(Icons.keyboard_arrow_right_rounded),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Center(
                child: SignOutButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
