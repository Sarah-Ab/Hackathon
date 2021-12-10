import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/mobile/widgets/artist_slider.dart';
import 'package:hackathon/mobile/widgets/custom_app_barmobile.dart';
import 'package:hackathon/mobile/widgets/event_slider.dart';

import 'artist_perday.dart';

class TousArtistes extends StatelessWidget {
  const TousArtistes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMobile(),
      body : ListView(

        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children:[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.list,
                    size: 24.0,
                    color: Colors.white,
                  ),
                  label: Text('artistes par jour', style: TextStyle(color:Colors.white)),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => //ArtistPerDay(jour: null,)),
                    // );
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
          ListViewAritistSlider(),
        ],
      ),
    );
  }
}
