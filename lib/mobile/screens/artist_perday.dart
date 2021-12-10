// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hackathon/dao/artiste_dao.dart';
// import 'package:hackathon/domain/artiste.dart';
// import 'package:hackathon/mobile/widgets/artist_card.dart';
//
//
// class ArtistPerDay extends StatefulWidget {
//   final int jour;
//
//   const ArtistPerDay({Key? key, required this.jour}) : super(key: key);
//
//
//   @override
//   _ArtistPerDayState createState() => _ArtistPerDayState();
// }
//
// class _ArtistPerDayState extends State<ArtistPerDay> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//       FutureBuilder(
//         future: ArtisteDao.instance.parJour(widget.jour),
//         // TODO le texte disparait, c'est à revoir !!!!
//         builder: (BuildContext context, AsyncSnapshot<List> artistSnap) => !artistSnap.hasData?
//         Center(
//           child: Column(
//             children:[
//               CircularProgressIndicator(),
//               Text("Aucun artiste à cette édition"),
//             ],
//           ),
//         ):
//         ListView.builder(
//           itemCount : artistSnap.data!.length ,
//           itemBuilder: (BuildContext context, index) => ArtistCard(artiste: (artistSnap.data!.elementAt(index)as Artiste)),
//         ),
//       ),
//
//     );
//   }
// }
