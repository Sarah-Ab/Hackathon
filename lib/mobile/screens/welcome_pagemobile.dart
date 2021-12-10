import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/mobile/screens/toutes_editions.dart';
import 'package:hackathon/mobile/widgets/event_slider.dart';
import 'package:hackathon/mobile/widgets/artist_slider.dart';

import '../widgets/custom_app_barmobile.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(WelcomePageMobile());
}

class WelcomePageMobile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Welcome page mobile',
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
        resizeToAvoidBottomInset: false,
      appBar: CustomAppBarMobile(),
      body :
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                  ElevatedButton.icon(
                    icon: Icon(
                      Icons.list,
                      size: 24.0,
                      color: Colors.white,
                    ),
                    label: Text('Toutes les éditions', style: TextStyle(color:Colors.white)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ToutesEditions()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                    ElevatedButton.icon(
                      label: Text('Tous les artistes', style: TextStyle(color:Colors.white)),
                      icon: Icon(
                        Icons.list,
                        size: 24.0,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        print('Pressed');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                     ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:20),
                child: Text("Nos éditions récentes",  style: TextStyle(fontSize: 24)),
              ),
              ListViewEventSlider(limiteAffichage: 10, anneeDebut: 2015, anneeFin: 2021),

            ],
          ),
    );
  }

}