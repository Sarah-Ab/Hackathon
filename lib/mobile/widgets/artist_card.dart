import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArtistCard extends StatefulWidget {

  final String date;
  final String artistName;
  final String imageUrl;

  const ArtistCard(
     this.date, this.artistName, this.imageUrl
  ) ;




  @override
  _ArtistCardState createState() => _ArtistCardState();
}

class _ArtistCardState extends State<ArtistCard> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        //height: 300,
        width: 300,
        child: Card(
          elevation: 8,
          shadowColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: InkWell(
            onTap: () {
              print('Card tapped.');
            },
            child: Wrap(
              alignment: WrapAlignment.center,
              children:[
                  ListTile(
                    title: Text(widget.date),
                    subtitle: Text(widget.artistName),
                  ),
              Container(
                height:200,
                width:250,
                child:Image.network(widget.imageUrl,fit: BoxFit.fill, alignment: Alignment.center),
              )


            ],
      ),


            ),
          ),

      );
  }
}
