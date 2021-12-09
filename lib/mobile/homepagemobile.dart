import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/custom_app_barmobile.dart';
import 'package:flutter_swiper/flutter_swiper.dart';




void main() async {

  runApp(HomePageMobile());
}
class HomePageMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scrollbar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePageMobile(),
    );
  }
}

class MyHomePageMobile extends StatefulWidget {
 //MyHomePageMobile({Key key, this.title}) : super(key: key);

  //final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePageMobile> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        CustomAppBarMobile(),
        body: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                 Container(
                   margin : EdgeInsets.all(8),
                   height: 200,
                   width: 200,
                 ),
                ],
              ),
            ),
          ),

    );
  }
}
