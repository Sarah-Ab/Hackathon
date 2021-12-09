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


class DeleteArtistePage extends StatefulWidget {
  const DeleteArtistePage({Key? key, required this.title, required this.user}) : super(key: key);
  final String title;
  final User user;

  @override
  State<StatefulWidget> createState() => DeleteArtistePageState();
}

class DeleteArtistePageState extends State<DeleteArtistePage> {



  final _formKey = GlobalKey<FormState>();

  TextEditingController nomController = TextEditingController(text: "");


  String? nom;
  String failResponse = "Connexion échouee. Reessayez!";
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
              const SizedBox(height: 12),
              Column(
                  children: [

                    const Center(
                      child : Padding(
                        padding: EdgeInsets.all(16),
                        child:
                        Text('Modifié d\'un artiste',
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
                            SizedBox(height: 12),






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
                              child: const Text('Envoyer la notification'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
              ),
            ]));
  }
}
