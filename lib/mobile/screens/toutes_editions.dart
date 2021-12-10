import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/mobile/widgets/custom_app_barmobile.dart';
import 'package:hackathon/mobile/widgets/event_slider.dart';

class ToutesEditions extends StatelessWidget {
  const ToutesEditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarMobile(),
        body : ListView(
          children:[
          ListViewEventSlider(limiteAffichage: 10000,anneeDebut: 1979, anneeFin: 2021),
          ],

        ),
    );
  }
}
