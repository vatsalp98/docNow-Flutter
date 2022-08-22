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

  static fetchDoctorInfo(String id) async {
    String gdoc = '''query Mquery(\$id: ID!){
      getUser(id: \$id) {
        birthday
        createdAt
        email
        expertise
        full_name
        gender
        id
        isDoctor
        isSpecialist
        location
        serviceLanguages
        clinic_id
        clinic {
          items {
            id
            location
            name
            serviceLanguages
            services
          }
        }
      }
    }''';
    try {
      var operation = Amplify.API.query(
        request: GraphQLRequest(
          document: gdoc,
          apiName: 'docnow',
          variables: {
            "id": id,
          },
        ),
      );
      var response = await operation.response;
      if (response.errors.isNotEmpty) {
        response.errors.forEach((element) {
          print(element.message);
        });
      } else {
        final data = json.decode(response.data);
        return data['getUser'];
      }
    } catch (e) {
      throw (e);
    }
  }
}
