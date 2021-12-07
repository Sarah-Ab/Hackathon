import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackathon/authentification.dart';
import './login.dart';
import './main.dart';

class MainPageForm extends StatefulWidget {
  const MainPageForm({Key? key, required this.title, required this.user}) : super(key: key);
  final String title;
  final User user;

  @override
  State<StatefulWidget> createState() => MainPageFormState();
}

class MainPageFormState extends State<MainPageForm> {


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
      body: Row(
        children : [ Column(
            children: [
          Row(
          children: [

          Column(
          children: [
              Visibility(
                visible: ("Exploitant" != widget.user.photoURL.toString()), // condition here

                  child: Row(
                    children: <Widget>[



              /*SizedBox(height: 12),
              Visibility(visible: showResponse, child: Text(failResponse)),
              Visibility(
                  visible: showLoading,
                  child: CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                  )),
              SizedBox(height: 18),*/


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
                  onPressed: () => print("Modifier"),
                  child: Text('Modifier Artiste'),
                ),
                ]
                ),

                ElevatedButton(
                  onPressed: () => print(Auth().user.isEmpty),
                  child: Text('Supprimer Artiste'),
                ),



              ]
              ),



              ),

          ],
          ),

              Column(
              children: [
            Align(
                alignment: Alignment.bottomLeft,
                child :ElevatedButton(
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
            ),
              ],
              ),


          ],
          ),
              Center(
                child : Column(

                  children : [
              const Padding(
                padding: EdgeInsets.all(16),
                child:
                Text('Bienvenu sur notre page d\'accueil',
                  textAlign: TextAlign.center,
                  style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),

              const SizedBox(height: 28),
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
              ),


                  ])),
              ],
          ),

      ]

      ),
    );
  }


}
