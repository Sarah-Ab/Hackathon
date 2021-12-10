import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackathon/authentification.dart';
import './login.dart';
import './deleteartiste.dart';
import './modifyartiste.dart';
import './main.dart';
import './createnotif.dart';
import './createartiste.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'dao/artiste_dao.dart';
import 'domain/artiste.dart';
import 'domain/edition.dart';
import 'domain/pays.dart';
import 'domain/projet.dart';

class MainPageForm extends StatefulWidget {
  const MainPageForm({Key? key, required this.title, required this.user}) : super(key: key);
  final String title;
  final User user;

  @override
  State<StatefulWidget> createState() => MainPageFormState();
}

Future<ProductDataGridSource> getProductDataSource() async {
  var artisteList = await ArtisteDao.instance.tous();
  return ProductDataGridSource(artisteList);
}
final int _rowsPerPage =15;
final double _dataPagerHeight = 60.0;

bool shouldRecalculateColumnWidths() {
  return true;
}
List<GridColumn> getColumns(){
  return <GridColumn>[
    GridColumn(
        columnName: 'recordid',
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('record ID',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'nom',
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('nom',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'edition',
        allowSorting: true,
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('edition',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'projets',
        width: 500,
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('projets',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'spotify',
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('spotify',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'deezer',
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('deezer',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'pays',
        allowSorting: true,
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('pays',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'langue',
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('langue',
                overflow: TextOverflow.clip, softWrap: true))),
  ];
}

class ProductDataGridSource extends DataGridSource{

  ProductDataGridSource(this.artisteList){
    buildDataGridRow();
  }
  late List<DataGridRow> dataGridRows;
  late List<Artiste> artisteList;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(4.0),

      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[1].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[2].value == null ? '' : row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          (row.getCells()[3].value as List<Projet>).isEmpty ? 'aucun projet': (
                  ((row.getCells()[3].value as List<Projet>)[0].nom.toString() == 'null' ? ' ' : (row.getCells()[3].value as List<Projet>)[0].nom.toString()) + ' ' +
                  ((row.getCells()[3].value as List<Projet>)[0].date.toString() == 'null' ? ' ' : (row.getCells()[3].value as List<Projet>)[0].date.toString()) + ' ' +
                   ((row.getCells()[3].value as List<Projet>)[0].salle.toString() == 'null' ? ' ' : (row.getCells()[3].value as List<Projet>)[0].salle.toString()) + ' ' +
                  ((row.getCells()[3].value as List<Projet>)[0].ville.toString() == 'null' ? ' ' : (row.getCells()[3].value as List<Projet>)[0].ville.toString())
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          ((row.getCells()[4].value.toString() == 'null' ? 'pas de lien' : (row.getCells()[4].value.toString()))),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          ((row.getCells()[5].value.toString() == 'null' ? 'pas de lien' : (row.getCells()[5].value.toString()))),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[6].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[7].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRow() {
    dataGridRows = artisteList.map<DataGridRow>((dataGridRow){
      return DataGridRow(cells: [
        DataGridCell(columnName: 'recordid', value: dataGridRow.recordid),
        DataGridCell<String>(columnName: 'nom', value: dataGridRow.nom),
        DataGridCell<Edition>(columnName: 'edition', value: dataGridRow.edition),
        DataGridCell<List<Projet>>(columnName: 'projet', value: dataGridRow.projets),
        DataGridCell<String>(columnName: 'spotify', value: dataGridRow.spotify),
        DataGridCell<String>(columnName: 'deezer', value: dataGridRow.deezer),
        DataGridCell<List<Pays>>(columnName: 'pays', value: dataGridRow.pays),
        DataGridCell<Locale>(columnName: 'langue', value: dataGridRow.langue),
      ]);

    }).toList(growable: false); }
}

class MainPageFormState extends State<MainPageForm> {


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String? email;
  String? password;
  String failResponse = "Connexion échouée. Reessayez!";
  bool showResponse = false;
  bool showLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
          title: Text(widget.title),
      ),
      body: Column(
        children : [
          SizedBox(height: 12),
          Column(
            children: [
          Row(
          children: [
            SizedBox(width: 16),
          Column(
          children: [
              Visibility(
                visible: ("Exploitant" != widget.user.photoURL.toString()), // condition here

                  child: Row(
                    children: <Widget>[

                Column( children : [ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateArtistePage(title: 'Gestionnaire des artistes', user: widget.user,)),
                    // onPressed: submit,
                  ),

                  child: const Text('Ajouter un artiste'),
                ),

                ]
                ),
                      const SizedBox(width: 8),
                Column( children : [
                ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ModifyArtistePage(title: 'Gestionnaire des artistes', user: widget.user,)),
                    // onPressed: submit,
                  ),
                  child: const Text('Modifier un artiste'),
                ),
                ]
                ),
                      const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeleteArtistePage(title: 'Gestionnaire des artistes', user: widget.user,)),
                    // onPressed: submit,
                  ),
                  child: const Text('Supprimer un artiste'),
                ),


                      SizedBox(width: 8),
              ]
              ),
              ),

            Visibility(
              visible: ("Exploitant" == widget.user.photoURL.toString()), // condition here

              child: Row(
                  children: <Widget>[

                    Column( children : [
                      ElevatedButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateNotifPage(title: 'Ajouter une notification', user: widget.user,)),
                        // onPressed: submit,
                      ),
                      child: Text('Ajouter Notification'),
                    ),
                    ]
                    ),
                    SizedBox(width: 8),
                  ]
              ),
            ),
          ],
          ),

              Column(

              children: [

           /* Align(
                alignment: Alignment.centerRight,
                child : */
                ElevatedButton(
                  onPressed: () {
                    Auth().signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(title: 'Bienvenu',)),
                      // onPressed: submit,
                    );
                  },
                  child: Text('Se déconnecter'),

                )
              ],
              ),
          ],
          ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.topLeft,
              child : Row(
                children : [
                  const SizedBox(width: 15),
                  Text(widget.user.displayName.toString() + " : connecté(e) en tant que "+ widget.user.photoURL.toString(),
                textAlign: TextAlign.right,
                style:
                const TextStyle(fontSize: 19),
              ),
                ]
              ),
              ),
              Center(
                child : Column(

                  children : [
              const Padding(
                padding: EdgeInsets.all(16),
                child:
                Text('Bienvenue sur notre page d\'accueil',
                  textAlign: TextAlign.center,
                  style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),


              /*const SizedBox(height: 28),
              Text("Mail : "+widget.user.email.toString(),
                textAlign: TextAlign.center,
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              const SizedBox(height: 18),
              Text("Name : "+ widget.user.displayName.toString(),
                textAlign: TextAlign.center,
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              const SizedBox(height: 18),
              Text("Role : "+widget.user.photoURL.toString(),
                textAlign: TextAlign.center,
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),*/
                  ])),
              ],
          ),
          Expanded(
            child : SafeArea (
                child : Scaffold(
                  body : FutureBuilder(
                      future: getProductDataSource(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                        return snapshot.hasData
                            ? SfDataGrid(source: snapshot.data, columns: getColumns(),allowTriStateSorting:true,allowSorting: true,allowColumnsResizing: true, allowMultiColumnSorting: true, showSortNumbers: true,)
                            :const Center(
                          child: CircularProgressIndicator(
                            strokeWidth:3 ,
                          ),
                        );

                      }
                  ),
                )
            ),
          ),


      ]

      ),
    );
  }


}
