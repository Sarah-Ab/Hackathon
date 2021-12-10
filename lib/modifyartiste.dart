import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hackathon/ColorCustom.dart';
import './main.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './authentification.dart';
import './mainpage.dart';


class ModifyArtistePage extends StatefulWidget {
  const ModifyArtistePage({Key? key, required this.title, required this.user}) : super(key: key);
  final String title;
  final User user;

  @override
  State<StatefulWidget> createState() => ModifyArtistePageState();
}

class ModifyArtistePageState extends State<ModifyArtistePage> {



  final _formKey = GlobalKey<FormState>();


  TextEditingController nomController = TextEditingController(text: "");
  TextEditingController ediYearsController = TextEditingController(text: "");
  TextEditingController ediNomController = TextEditingController(text: "");
  TextEditingController projetNomController = TextEditingController(text: "");
  TextEditingController projetDateController = TextEditingController(text: "");
  TextEditingController projetSalleController = TextEditingController(text: "");
  TextEditingController projetVilleController = TextEditingController(text: "");
  TextEditingController linkSpotiController = TextEditingController(text: "");
  TextEditingController linkDeezController = TextEditingController(text: "");
  TextEditingController countryController = TextEditingController(text: "");
  TextEditingController idController = TextEditingController(text: "");



  String? id;
  String? nom;
  String? ediYears;
  String? ediNom;
  String? projetNom;
  String? projetDate;
  String? projetSalle;
  String? projetVille;
  String? linkSpoti;
  String? linkDeez;
  String? country;

  String failResponse = "Connexion échouee. Reessayez!";
  bool showResponse = false;
  bool showLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            child : Column(
                children : [
                  const SizedBox(height: 12),
                  Column(
                      children: [

                        const Center(
                          child : Padding(
                            padding: EdgeInsets.all(16),
                            child:
                            Text('Modification d\'un artiste',
                              textAlign: TextAlign.center,
                              style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child : Row(

                              children : [
                                const SizedBox(width: 25),
                                Text("Auteur : "+widget.user.displayName.toString(),
                                  style:
                                  const TextStyle(fontSize: 35),
                                ),
                              ]),
                        ),
                        SizedBox(width: 52),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [


                                Align(
                                  alignment: Alignment.centerLeft,
                                  child : Row(

                                      children : const [
                                        Text("Record ID de l\'artiste :",
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                        ),
                                      ]),
                                ),
                                TextFormField(
                                  controller: idController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'ID de l\'artiste';
                                    }
                                    return null;
                                  },
                                  onSaved: (id) => this.id = id,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'ID de l\'artiste',
                                  ),
                                ),
                                SizedBox(height: 37),


                                Align(
                                  alignment: Alignment.centerLeft,
                                  child : Row(

                                      children : const [
                                        Text("Nom de l\'artiste :",
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                        ),
                                      ]),
                                ),
                                TextFormField(
                                  controller: nomController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Nom';
                                    }
                                    return null;
                                  },
                                  onSaved: (nom) => this.nom = nom,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Nom',
                                  ),
                                ),
                                SizedBox(height: 37),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child : Row(

                                      children : const [
                                        Text("Edition de l\'artiste :",
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                        ),
                                      ]),
                                ),
                                TextFormField(
                                  controller: ediYearsController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Année de l\'édition';
                                    }
                                    return null;
                                  },
                                  onSaved: (ediYears) => this.ediYears = ediYears,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Année de l\'édition',
                                  ),
                                ),
                                SizedBox(height: 12),

                                TextFormField(
                                  controller: ediNomController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Nom de l\'édition';
                                    }
                                    return null;
                                  },
                                  onSaved: (ediNom) => this.ediNom = ediNom,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Nom de l\'édition',
                                  ),
                                ),
                                SizedBox(height: 37),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child : Row(

                                      children : const [
                                        Text("Projet de l\'artiste :",
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                        ),
                                      ]),
                                ),
                                TextFormField(
                                  controller: projetNomController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Nom du projet';
                                    }
                                    return null;
                                  },
                                  onSaved: (projetNom) => this.projetNom = projetNom,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Nom du projet',
                                  ),
                                ),
                                SizedBox(height: 12),

                                TextFormField(
                                  controller: projetDateController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Date du projet';
                                    }
                                    return null;
                                  },
                                  onSaved: (projetDate) => this.projetDate = projetDate,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Date du projet',
                                  ),
                                ),
                                SizedBox(height: 12),

                                TextFormField(
                                  controller: projetSalleController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Salle du projet';
                                    }
                                    return null;
                                  },
                                  onSaved: (projetSalle) => this.projetSalle = projetSalle,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Salle du projet',
                                  ),
                                ),
                                SizedBox(height: 12),

                                TextFormField(
                                  controller: projetVilleController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ville du projet';
                                    }
                                    return null;
                                  },
                                  onSaved: (projetVille) => this.projetVille = projetVille,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Ville du projet',
                                  ),
                                ),
                                SizedBox(height: 37),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child : Row(

                                      children : const [
                                        Text("Lien de l\'artiste :",
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                        ),
                                      ]),
                                ),
                                TextFormField(
                                  controller: linkSpotiController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Spotify de l\'artiste';
                                    }
                                    return null;
                                  },
                                  onSaved: (linkSpoti) => this.linkSpoti = linkSpoti,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Spotify de l\'artiste',
                                  ),
                                ),
                                SizedBox(height: 12),

                                TextFormField(
                                  controller: linkDeezController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Deezer de l\'artiste';
                                    }
                                    return null;
                                  },
                                  onSaved: (linkDeez) => this.linkDeez = linkDeez,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Deezer de l\'artiste',
                                  ),
                                ),
                                SizedBox(height: 37),


                                Align(
                                  alignment: Alignment.centerLeft,
                                  child : Row(

                                      children : const [
                                        Text("Pays de l\'artiste :",
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                        ),
                                      ]),
                                ),
                                TextFormField(
                                  controller: countryController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Nom du pays de l\'artiste en français';
                                    }
                                    return null;
                                  },
                                  onSaved: (country) => this.country = country,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Nom du pays de l\'artiste en français',
                                  ),
                                ),
                                SizedBox(height: 32),

                                Visibility(visible: showResponse, child: Text(failResponse)),
                                Visibility(
                                    visible: showLoading,
                                    child: CircularProgressIndicator(
                                      valueColor:
                                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                                    )),
                                const SizedBox(height: 18),
                                ElevatedButton(
                                  onPressed: () {
                                    print("Crée l'artiste");
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainPageForm(title: 'Accueil', user: widget.user,)),
                                    );
                                  },
                                  child: const Text('Validé la modification'),
                                ),
                                SizedBox(height: 72),
                              ],
                            ),
                          ),
                        ),
                      ]
                  ),
                ])));
  }
}
