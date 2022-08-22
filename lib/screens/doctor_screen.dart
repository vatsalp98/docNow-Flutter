import 'package:docnow/widgets/bookNowButton.dart';
import 'package:docnow/widgets/emailButton.dart';
import 'package:docnow/widgets/messageButton.dart';
import 'package:docnow/widgets/servicesList.dart';
import 'package:flutter/material.dart';

import '../widgets/voiceCallButton.dart';

class DoctorScreen extends StatefulWidget {
  DoctorScreen({Key? key, required this.doctorData}) : super(key: key);

  final Map doctorData;
  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Dr. ' + widget.doctorData['full_name'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/doc.jpg',
                height: 300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  voiceCallButton(widget.doctorData['email']),
                  emailButton(widget.doctorData['email']),
                  messageButton(widget.doctorData['email']),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                bottom: 3,
                top: 5,
              ),
              child: servicesList(widget.doctorData['expertise'],
                  widget.doctorData['expertise'].length),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                widget.doctorData['clinic']['items'][0]['name'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 30,
              ),
              child: Text(
                'About Dr.${widget.doctorData['full_name'].split(' ')[0]}',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                style: TextStyle(
                  fontSize: 14,
                ),
                softWrap: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Center(
                child: bookNowButton(
                    widget.doctorData['id'], widget.doctorData['clinic_id']),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
