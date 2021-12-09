import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/mobile/widgets/event_slider.dart';
import 'package:hackathon/mobile/widgets/artist_slider.dart';

import '../widgets/custom_app_barmobile.dart';



void main()=> runApp(WelcomePageMobile());

class WelcomePageMobile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Test Welcome Page Carousel',
      theme : ThemeData(
        primarySwatch: Colors.red,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
          onPrimary: Colors.orange,
            ),
        ),
      ),
      home:MyWelcomePageMobile(),
    );
  }
}

class MyWelcomePageMobile extends StatefulWidget {

  @override
  _WelcomePageMobile createState() => _WelcomePageMobile();
}

class _WelcomePageMobile extends State<MyWelcomePageMobile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMobile(),
      body :
          Column(
            children: [
              ListViewEventSlider(),
              IconButton(
                icon: const Icon(Icons.navigate_next_outlined),
                tooltip: 'acces aux éditions plus anciennes',
                onPressed: () {

                },
              ),
              Text('plus d\'éditions'),
            ],
          ),
    );
  }

}