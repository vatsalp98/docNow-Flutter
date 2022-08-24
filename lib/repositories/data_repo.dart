import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';

class DataRepo {
  static fetchDoctors() async {
    String gDoc = '''query MyQuery {
      listUsers(filter: {isDoctor: {eq: true}, isSpecialist: {ne: true}}) {
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
    } on ApiException catch (e) {
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
    } on ApiException catch (e) {
      throw (e);
    }
  }

  static createActiveHours(
      String doctor_id, String schedule, int weekNumber) async {
    String gDoc =
        '''mutation Mmutation(\$user_id: ID!, \$schedule: String!, \$weekNumber: Int!){
      createActiveHours(input: {user_id: \$user_id, schedule: \$schedule, weekNumber: \$weekNumber}) {
        id
      }
    }''';
    // Map schedule = {
    //   "monday": "9-18",
    //   "tuesday": "9-18",
    //   "wednesday": "9-18",
    //   "thursday": "9-18",
    //   "friday": "9-18",
    //   "saturday": "10-16",
    //   "sunday": "10-16"
    // };
    try {
      var operation = Amplify.API.mutate(
        request: GraphQLRequest(
          document: gDoc,
          apiName: 'docnow',
          variables: {
            "user_id": doctor_id,
            "schedule": schedule,
            "weekNumber": weekNumber,
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
        return data;
      }
    } on ApiException catch (e) {
      throw (e);
    }
  }

  static fetchActiveHours(int weekNumber) async {
    var user1 = await Amplify.Auth.getCurrentUser();
    String gDoc = '''query Mquery(\$eq : ID, \$eq1: Int){
      listActiveHours(filter: {user_id: {eq: \$eq}, weekNumber: {eq: \$eq1}}) {
        items {
          id
          schedule
          updatedAt
        }
      }
    }''';

    try {
      var operation = Amplify.API.query(
        request: GraphQLRequest(
          document: gDoc,
          apiName: 'docnow',
          variables: {
            'eq': user1.userId,
            'eq1': weekNumber,
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
        return data;
      }
    } on ApiException catch (e) {
      throw (e);
    }
  }
}
