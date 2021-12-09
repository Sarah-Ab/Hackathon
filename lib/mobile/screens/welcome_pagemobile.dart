import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/mobile/widgets/listview_artistslider.dart';
import 'package:hackathon/mobile/widgets/listview_eventslider.dart';

import '../widgets/custom_app_barmobile.dart';


void main()=> runApp(WelcomePageMobile());

class WelcomePageMobile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Test Welcome Page Carousel',
      theme : ThemeData(
        primarySwatch: Colors.lime,
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
              ListViewArtistSlider(),
              Text("Events"),
              ListViewEventSlider(),
            ],
          ),
    );
  }

}