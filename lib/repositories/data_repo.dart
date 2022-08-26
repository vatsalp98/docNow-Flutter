import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:week_of_year/week_of_year.dart';

class DataRepo {
  static fetchClinicInfo(String id) async {
    String gDoc = '''query Mquery(\$id: ID!){
      getClinic(id: \$id) {
        id
        location
        name
        serviceLanguages
        services
      }
    }''';
    try {
      final operation = Amplify.API.query(
        request: GraphQLRequest(
          document: gDoc,
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
        return data;
      }
    } on ApiException catch (e) {
      throw (e);
    }
  }

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

  static createActiveHours(int slotNumber, int weekNumber, String date) async {
    final user = await Amplify.Auth.getCurrentUser();
    String gDoc =
        '''mutation Mmutation(\$user_id: ID!, \$weekNumber: Int!, \$date: AWSDateTime!, \$totalSlots: Int!){
      createActiveHours(input: {date: \$date, totalSlots: \$totalSlots, user_id: \$user_id, weekNumber: \$weekNumber}) {
        id
      }
    }''';
    try {
      var operation = Amplify.API.mutate(
        request: GraphQLRequest(
          document: gDoc,
          apiName: 'docnow',
          variables: {
            "user_id": user.userId,
            "weekNumber": weekNumber,
            "date": date,
            "totalSlots": slotNumber,
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
          date
          weekNumber
          updatedAt
          totalSlots
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

  static fetchSlotsForBookingDay() async {
    final user = await Amplify.Auth.getCurrentUser();
    print(user.userId);
    String gDoc = '''query Mquery(\$eq: ID, \$eq1: Int){
      listActiveHours(filter: {user_id: {eq: \$eq}, weekNumber: {eq: \$eq1}}) {
        items {
          id
          totalSlots
          date
          user_id
          weekNumber
        }
      }
    }''';
    try {
      var operation = Amplify.API.query(
        request: GraphQLRequest(
          document: gDoc,
          apiName: 'docnow',
          variables: {
            "eq": user.userId,
            "eq1": DateTime.now().weekOfYear,
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

  static createBooking(Map bookingData) async {
    print(bookingData);
    String gDoc =
        '''mutation Mmutation (\$booking_date: AWSDateTime!, \$booking_time: AWSDateTime!, \$clinic_id: ID!, \$doctor_id: ID!, \$isActive: Boolean!, \$location: String, \$patient_id: ID) {
      createBooking(input: {booking_date: \$booking_date, booking_time: \$booking_time, clinic_id: \$clinic_id, doctor_id: \$doctor_id, isActive: \$isActive, location: \$location, patient_id: \$patient_id}) {
        id
      }
    }''';
    try {
      final operation = Amplify.API.mutate(
        request: GraphQLRequest(
          document: gDoc,
          apiName: 'docnow',
          variables: {
            "doctor_id": bookingData["doctor_id"],
            "clinic_id": bookingData["clinic_id"],
            "booking_date": bookingData["date"],
            "booking_time": bookingData["date"],
            "isActive": false,
            "location": bookingData["location"],
            "patient_id": bookingData["patient_id"],
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

  static updateActiveHoursSlot(int totalSlots, String id) async {
    String gDoc = '''mutation Mmutation(\$id: ID!, \$totalSlots: Int){
      updateActiveHours(input: {id: \$id, totalSlots: \$totalSlots}) {
        id
        totalSlots
      }
    }''';
    try {
      final operation = Amplify.API.mutate(
        request: GraphQLRequest(
          document: gDoc,
          apiName: 'docnow',
          variables: {
            'id': id,
            "totalSlots": totalSlots - 1,
          },
        ),
      );
      final response = await operation.response;
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

  static fetchUserBookings() async {
    final user = await Amplify.Auth.getCurrentUser();
    String gDoc = '''query Mquery(\$eq: ID){
      listBookings(filter: {patient_id: {eq: \$eq}}) {
        items {
          booking_date
          clinic_id
          doctor_id
          id
          isActive
          location
          booking_time
        }
      }
    }''';
    try {
      final operation = await Amplify.API.query(
        request: GraphQLRequest(
          document: gDoc,
          apiName: 'docnow',
          variables: {
            "eq": user.userId,
          },
        ),
      );
      final response = await operation.response;
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

  static deleteBooking(String id) async {
    String gDoc = '''mutation Mmutation(\$id: ID!){
      deleteBooking(input: {id: \$id}) {
        id
      }
    }''';
    try {
      final operation = Amplify.API.mutate(
        request: GraphQLRequest(
          document: gDoc,
          apiName: 'docnow',
          variables: {"id": id},
        ),
      );
      final response = await operation.response;
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
