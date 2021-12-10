import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';

import './main.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './authentification.dart';
import './mainpage.dart';
import 'dao/artiste_dao.dart';
import 'domain/projet.dart';
import 'domain/pays.dart';
import 'domain/artiste.dart';
import 'domain/edition.dart';


class CreateArtistePage extends StatefulWidget {
  const CreateArtistePage({Key? key, required this.title, required this.user}) : super(key: key);
  final String title;
  final User user;

  @override
  State<StatefulWidget> createState() => CreateArtistePageState();
}

class CreateArtistePageState extends State<CreateArtistePage> {



  final _formKey = GlobalKey<FormState>();

  TextEditingController nomController = TextEditingController(text: "");
  //TextEditingController ediYearsController = TextEditingController(text: "");
  //TextEditingController ediNomController = TextEditingController(text: "");
  TextEditingController projetNomController = TextEditingController(text: "");
  TextEditingController projetDateAnneController = TextEditingController(text: "");
  TextEditingController projetSalleController = TextEditingController(text: "");
  TextEditingController projetVilleController = TextEditingController(text: "");
  TextEditingController linkSpotiController = TextEditingController(text: "");
  TextEditingController linkDeezController = TextEditingController(text: "");
  TextEditingController countryController = TextEditingController(text: "");
  TextEditingController projetDateDayController = TextEditingController(text: "");
  TextEditingController projetDateMoisController = TextEditingController(text: "");

  Future<void> createArtisteById(String nomArt,/*int editionAnnee, String editionNom,*/String projNom,int projDateYears,int projDateMonth,int projDateDay, String projSa, String projVil,String linkSpo,String linkDe,String contr) async {

    DateTime data = DateTime(projDateYears,projDateMonth,projDateDay);
    var projettmp = Projet(nom: projNom,date: data, salle: projSa,ville: projVil);
    var editiontmp = Edition(annee: 2021, nom: "Edition 2021");
    var paystmp = Pays(fr: contr);
    var projetList = [projettmp];
    var paysList = [paystmp];

    var artiste = Artiste(nom: nomArt, projets: projetList, pays: paysList, deezer: linkDe,spotify: linkSpo, edition: editiontmp );
    print("Call Create with ");

    if(artiste != null) {
      ArtisteDao.instance.sauvegarder(artiste);
      print("Artiste bien créee !!!!");
      //var artiste = await ArtisteDao.instance.parRecordId(id);
      //print("Artiste trouver : " +artiste!.nom);
      //if (artiste != null) {
       // ArtisteDao.instance.supprimer(artiste);
       // print("Artiste Supprimer");
      //}
    }
  }


  String? nom;
  String? ediYears;
  String? ediNom;
  String? projetNom;
  String? projetDateAnne;
  String? projetDateDay;
  String? projetDateMois;
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
      resizeToAvoidBottomInset: false,
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
                        Text('Création d\'un artiste',
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

                            /*Align(
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
                            SizedBox(height: 37),*/

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
                              controller: projetDateAnneController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Année du projet';
                                }
                                return null;
                              },
                              onSaved: (projetDateAnne) => this.projetDateAnne = projetDateAnne,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Année du projet',
                              ),
                            ),
                            SizedBox(height: 12),
                                TextFormField(
                                  controller: projetDateMoisController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Mois du projet';
                                    }
                                    return null;
                                  },
                                  onSaved: (projetDateMois) => this.projetDateMois = projetDateMois,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Mois du projet',
                                  ),
                                ),
                            SizedBox(height: 12),
                                TextFormField(
                                  controller: projetDateDayController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Jour du projet';
                                    }
                                    return null;
                                  },
                                  onSaved: (projetDateDay) => this.projetDateDay = projetDateDay,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Jour du projet',
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
                                    createArtisteById(nomController.text.toString(), /*int.parse(ediYearsController.text.toString()), ediNomController.text.toString(),*/ projetNomController.text.toString(), int.parse(projetDateAnneController.text.toString()), int.parse(projetDateMoisController.text.toString()), int.parse(projetDateDayController.text.toString()), projetSalleController.text.toString(), projetVilleController.text.toString(), linkSpotiController.text.toString(), linkDeezController.text.toString(), countryController.text.toString());
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainPageForm(title: 'Accueil', user: widget.user,)),
                                    );
                                  },
                                  child: const Text('Valider la création'),
                                ),

                            SizedBox(height: 22),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainPageForm(title: 'Accueil', user: widget.user,)),
                                );
                              },
                              child: const Text('Annuler la création'),
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
