import 'dart:convert';

import 'package:docnow/helpers/medicalCategories.dart';
import 'package:docnow/screens/settings_screen.dart';
import 'package:docnow/widgets/categoryCard.dart';
import 'package:docnow/widgets/recomendedDocCard.dart';
import 'package:docnow/widgets/topHomeTitle.dart';
import 'package:flutter/material.dart';

import '../repositories/data_repo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: homeTitle()),
            SizedBox(
              height: 165,
              child: FutureBuilder(
                future: DataRepo.fetchDoctors(),
                builder: ((context, snapshot) {
                  var data = snapshot.data as Map;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data['listUsers']['items'].length,
                    itemBuilder: (context, index) {
                      var item = data['listUsers']['items'][index];
                      var clinic = data['listUsers']['items'][index]['clinic']
                          ['items'][0];
                      return homeDocCard(context, item['id'], item['full_name'],
                          clinic['name'], item['expertise']);
                    },
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8, top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final Map item = categories[index];
                  return categoryCard(item['title'], item['imgAsset']);
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 250,
              child: FutureBuilder(
                future: DataRepo.fetchDoctors(),
                builder: ((context, snapshot) {
                  var data = snapshot.data as Map;
                  return ListView.builder(
                    itemCount: data['listUsers']['items'].length,
                    itemBuilder: (context, index) {
                      var item = data['listUsers']['items'][index];
                      return ListTile(
                        title: Text(item['full_name']),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
