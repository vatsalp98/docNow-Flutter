import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';

class DataRepo {
  static fetchDoctors() async {
    String gDoc = '''query MyQuery {
      listUsers(filter: {isDoctor: {eq: true}}) {
          items {
            email
            expertise
            full_name
            id
            gender
            location
            clinic {
              items {
                id
                name
                location
                services
                serviceLanguages
              }
            }
          }
      }
    }''';

    try {
      final operation = Amplify.API.query(
        request: GraphQLRequest(
          document: gDoc,
          apiName: 'docnow',
        ),
      );
      var response = await operation.response;
      if (response.errors.isNotEmpty) {
        response.errors.forEach((element) {
          print(element.message);
        });
      } else {
        final data = json.decode(response.data);
        return data;
      }
    } catch (e) {
      throw (e);
    }
  }
}
