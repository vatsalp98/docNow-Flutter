import 'package:docnow/helpers/medicalCategories.dart';
import 'package:docnow/screens/settings_screen.dart';
import 'package:docnow/widgets/categoryCard.dart';
import 'package:docnow/widgets/recomendedDocCard.dart';
import 'package:docnow/widgets/topHomeTitle.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: homeTitle()),
          Container(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                homeDocCard(),
                homeDocCard(),
                homeDocCard(),
                homeDocCard(),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 8.0, right: 8, top: 20, bottom: 20),
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
        ],
      ),
    );
  }
}
