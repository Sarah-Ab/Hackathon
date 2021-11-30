import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainPageForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageFormState();
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
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Bienvenue sur notre page de connexion',
                textAlign: TextAlign.center,
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),


              SizedBox(height: 12),
              Visibility(visible: showResponse, child: Text(failResponse)),
              Visibility(
                  visible: showLoading,
                  child: CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                  )),
              SizedBox(height: 18),

            ],
          ),
        ));
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
