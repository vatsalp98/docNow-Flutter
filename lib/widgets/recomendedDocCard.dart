import 'package:docnow/screens/doctor_screen.dart';
import 'package:flutter/material.dart';
import '../repositories/data_repo.dart';

Widget homeDocCard(BuildContext context, String id, String title, String clinic,
    List expertise) {
  return GestureDetector(
    onTap: () async {
      final dataMap = await DataRepo.fetchDoctorInfo(id);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return DoctorScreen(doctorData: dataMap);
      }));
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: Colors.blue[700],
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Looking for your desired',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'specialist doctor?',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 10,
                  ),
                  child: Container(
                    width: 180,
                    height: title.length > 25 ? 55 : 50,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. ' + title,
                            style: TextStyle(
                              fontSize: title.length > 22 ? 11 : 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: title.length > 20 ? 11 : 12,
                                color: Colors.white,
                              ),
                              children: [
                                expertise.length > 1
                                    ? TextSpan(
                                        text:
                                            expertise[0] + ' & ' + expertise[1])
                                    : TextSpan(text: expertise[0])
                              ],
                            ),
                          ),
                          Text(
                            clinic,
                            style: TextStyle(
                              fontSize: title.length > 25 ? 12 : 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9.0),
              child: Image.asset(
                'assets/doc.jpg',
                width: 110,
                height: 110,
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
