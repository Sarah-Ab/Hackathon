import 'dart:async';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
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
              Container(
                width: 350,
                child: TextFormField(
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText: "Veuillez entrer un adresse mail"),
                    EmailValidator(
                        errorText: "Veuillez entrer une adresse mail valide"),
                  ]),
                  controller: _emailController,
                  // validator: (val) => !EmailValidator.validate(val!, true)
                  //     ? 'Entrer votre adresse mail.'
                  //     : null,
                  // onSaved: (email) => this.email = email,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Email'),
                ),
              ),
              Container(
                width: 350,
                child: TextFormField(
                  validator: RequiredValidator(
                      errorText: "Veuillez entrer un mot de passe"),
                  onSaved: (password) => this.password = password,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Mot de passe',
                  ),
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
              SizedBox(height: 18),
              ElevatedButton(
                onPressed: submit,
                child: Text('Se connecter'),
              )
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
