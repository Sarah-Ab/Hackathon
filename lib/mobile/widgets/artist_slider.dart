import 'package:flutter/cupertino.dart';
import 'event_card.dart';
import 'notification_card.dart';

class ListViewAritistSlider extends StatefulWidget {
  const ListViewAritistSlider({Key? key}) : super(key: key);

  @override
  _ListViewAritistSliderState createState() => _ListViewAritistSliderState();
}

class _ListViewAritistSliderState extends State<ListViewAritistSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      height: 300,
      child:
      ListView(
        scrollDirection: Axis.vertical,
        children:[
          // EventCard('Event1','12/02/2022','Descrioptuihjakhdakulhfizjir'),
          // EventCard('Event2','15/02/2022','Descrioptuihjakhdakulhfizjir'),
          // EventCard('Event3','17/02/2022','Descrioptuihjakhdakulhfizjir'),
          // EventCard('Event4','19/02/2022','Descrioptuihjakhdakulhfizjir'),
          // EventCard('Tititre','22/02/2022','Descrioptuihjakhdakulhfizjir'),
        ],
      ),
    );
  }
}
