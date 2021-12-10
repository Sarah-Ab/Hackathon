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

import 'search.dart';
import 'dao/artiste_dao.dart';
import 'domain/artiste.dart';
import 'domain/edition.dart';
import 'domain/pays.dart';
import 'domain/projet.dart';



class SearchBar extends StatefulWidget {
  const SearchBar({Key? key, required this.title, required this.user}) : super(key: key);
  final String title;
  final User user;
  @override
  _SearchBar createState() => _SearchBar();
}
late Map<String, double> columnWidths = {
  'recordid': double.nan,
  'nom': double.nan,
  'edition': double.nan,
  'projets': double.nan,
  'spotify': double.nan,
  'deezer': double.nan,
  'pays': double.nan,
  'langue': double.nan

};

final int _rowsPerPage =15;
final double _dataPagerHeight = 60.0;

bool shouldRecalculateColumnWidths() {
  return true;
}
List<GridColumn> getColumns(){
  return <GridColumn>[
    GridColumn(
        width: columnWidths['recordid']!,
        columnName: 'recordid',
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('record ID',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        width: columnWidths['nom']!,
        columnName: 'nom',
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('nom',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        width: columnWidths['edition']!,
        columnName: 'edition',
        allowSorting: true,
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('edition',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'projets',
        width: columnWidths['projets']!,
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('projets',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        width: columnWidths['spotify']!,
        columnName: 'spotify',
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('spotify',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        width: columnWidths['deezer']!,
        columnName: 'deezer',
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('deezer',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        width: columnWidths['pays']!,
        columnName: 'pays',
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('pays',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        width: columnWidths['langue']!,
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
          row.getCells()[1].value,
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



class _SearchBar extends State<SearchBar> {
  String result ="";
  Future<ProductDataGridSource> getProductDataSource() async {
    var artisteList = await ArtisteDao.instance.matchNom(result);
    return ProductDataGridSource(artisteList);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("Input text")),
      body : Center (
        child : Column(
          children : <Widget>[
            TextField(
              decoration: const InputDecoration(
                hintText: "Type in here !"
              ),
    onChanged: (String str) {
                setState(() {
                  result = str;
                });

            }
            ),
            Text(result),
            Expanded(
              child : SafeArea (
                  child : Scaffold(
                    body : FutureBuilder(
                        future: getProductDataSource() ,

                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                          return snapshot.hasData
                              ? SfDataGrid(source: snapshot.data,
                            columns: getColumns(),
                            allowTriStateSorting:true,
                            allowSorting: true,
                            allowColumnsResizing: true,
                            onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                              setState(() {
                                columnWidths[details.column.columnName] = details.width;
                              });
                              return true;
                            },
                            allowMultiColumnSorting: true,
                            showSortNumbers: true,)
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
        )
      )
    );
  }

}