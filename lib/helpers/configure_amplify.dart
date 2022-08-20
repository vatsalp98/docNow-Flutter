import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../amplifyconfiguration.dart';

Future<void> configureAmplify() async {
  // Add any Amplify plugins you want to use
  final authPlugin = AmplifyAuthCognito();
  final apiPlugin = AmplifyAPI();
  await Amplify.addPlugins([authPlugin, apiPlugin]);

  try {
    await Amplify.configure(amplifyconfig);
  } on AmplifyAlreadyConfiguredException {
    throw ("Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
  }
}
