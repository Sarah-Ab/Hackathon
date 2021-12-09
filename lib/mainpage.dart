import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import './login.dart';
import './main.dart';
import 'package:hackathon/Table/multiplication_table.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:hackathon/dao/artiste_dao.dart';

import 'domain/artiste.dart';
import 'domain/edition.dart';
import 'domain/pays.dart';
import 'domain/projet.dart';




class MainPageForm extends StatefulWidget {
  const MainPageForm({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => MainPageFormState();
}
Future<ProductDataGridSource> getProductDataSource() async {
  var artisteList = await ArtisteDao.instance.tous();
  return ProductDataGridSource(artisteList);
}

List<GridColumn> getColumns(){
  return <GridColumn>[
    GridColumn(
        columnName: 'recordid',
        width: 100,
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('record ID',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'nom',
        width: 70,
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerRight,
            child: const Text('nom',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'edition',
        width: 70,
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('edition',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'projets',
        width: 70,
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('projets',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'spotify',
        width: 70,
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('spotify',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'deezer',
        width: 70,
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('deezer',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'pays',
        width: 70,
        label: Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text('pays',
                overflow: TextOverflow.clip, softWrap: true))),
    GridColumn(
        columnName: 'langue',
        width: 70,
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
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[3].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[4].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[5].value.toString(),
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
  final _formKey = GlobalKey<FormState>();




  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? email;
  String? password;
  String failResponse = "Connexion échouee. Reessayez!";
  bool showResponse = false;
  bool showLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
          title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [


              /*SizedBox(height: 12),
              Visibility(visible: showResponse, child: Text(failResponse)),
              Visibility(
                  visible: showLoading,
                  child: CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                  )),
              SizedBox(height: 18),*/
              Row(
              children: [

                Column( children : [ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(title: 'Bienvenu',)),
                    // onPressed: submit,
                  ),

                  child: Text('Ajouter Artiste'),
                ),
                ]
                ),
                Column( children : [
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(title: 'Bienvenu',)),
                    // onPressed: submit,
                  ),
                  child: Text('Modifier Artiste'),
                ),
                ]
                ),

                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(title: 'Bienvenu',)),
                    // onPressed: submit,
                  ),
                  child: Text('Supprimer Artiste'),
                ),
                Align(
              alignment: Alignment.topRight,
              child :ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(title: 'Bienvenu',)),
                  // onPressed: submit,
                ),
                child: Text('Se déconnecter'),

              )
              ),


              ]
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child:
                Text(
                  'Bienvenu sur notre page d\'accueil',
                  textAlign: TextAlign.center,
                  style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
              Expanded(
              child : SafeArea (
                child : Scaffold(
                  body : FutureBuilder(
                    future: getProductDataSource(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                      return snapshot.hasData
                          ? SfDataGrid(source: snapshot.data, columns: getColumns())
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
              ],

          ),
        )),
    );
  }

  Future submit() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        showLoading = true;
        showResponse = false;
      });
    }
  }
}
