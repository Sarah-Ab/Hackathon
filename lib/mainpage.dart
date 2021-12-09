import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackathon/authentification.dart';
import './login.dart';
import './main.dart';
import './createnotif.dart';
import './createartiste.dart';

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
                  onPressed: () => print("Modifier"),
                  child: const Text('Modifier un artiste'),
                ),
                ]
                ),
                      const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => print(Auth().user.isEmpty),
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
                            builder: (context) => CreateNotifPage(title: 'Ajouté une notification', user: widget.user,)),
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
                  Text(widget.user.displayName.toString() + " : connecter en tant que "+ widget.user.photoURL.toString(),
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
                Text('Bienvenu sur notre page d\'accueil',
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

      ]

      ),
    );
  }


}
