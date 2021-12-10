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
import 'domain/notification.dart';
import 'services/notification_sender.dart';


  class CreateNotifPage extends StatefulWidget {
  const CreateNotifPage({Key? key, required this.title, required this.user}) : super(key: key);
  final String title;
  final User user;

  @override
    State<StatefulWidget> createState() => CreateNotifPageState();
  }

  class CreateNotifPageState extends State<CreateNotifPage> {


    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();


    final _formKey = GlobalKey<FormState>();

    TextEditingController titleNController = TextEditingController(text: "");
    TextEditingController textController = TextEditingController(text: "");


    String? titleN;
    String? text;
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
            SizedBox(height: 12),
            Column(
              children: [

                    Center(
                    child : Padding(
                      padding: EdgeInsets.all(16),
                      child:
                      Text('Notification',
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
                      SizedBox(width: 25),
                    Text("Auteur : "+widget.user.displayName.toString(),
                          style:
                          TextStyle(fontSize: 35),
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
                        controller: titleNController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ecrivez le titre de la nouvelle notification';
                          }
                          return null;
                        },
                        onSaved: (titleN) => this.titleN = titleN,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Ecrivez le titre de la nouvelle notification',
                        ),
                      ),
                      TextFormField(
                        controller: textController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ecrivez la notification';
                          }
                          return null;
                        },
                        onSaved: (text) => this.text = text,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Ecrivez la notification',
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
                          NotificationSender.instance.envoyer(NotificationChangement(titre: titleNController.text.toString(), corps: textController.text.toString()));

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPageForm(title: 'Accueil', user: widget.user,)),
                          );
                          },
                        child: const Text('Envoyer la notification'),
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
                        child: const Text('Ne pas envoyer la notification'),
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
