import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import './main.dart';

void main() async {
  runApp(Test());
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Inscription'),
        ),
        body: Center(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //SizedBox(height:100),
                    SignUpForm(),
                  ],
                ),
              ),
              Expanded(
                child: FittedBox(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 1, minHeight: 1),
                    // here
                    child: Image.asset(path_image_login),
                  ),
                  fit: BoxFit.fill,
                ),
              ),

              ],
          ),
        ),
      ),
    );
  }
}

class SignUpFormSelect extends StatefulWidget {
  const SignUpFormSelect({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => SignUpFormSelctState();

}
class SignUpFormSelctState extends State<SignUpFormSelect> {

  String?  _dropDownText;
  @override
  Widget build(BuildContext context) {
    return
      Align(
        alignment: Alignment.bottomLeft,
        child: DropdownButton<String>(
            items: <String>['Programmateur', 'Exploitant']
                .map((String value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child:
                  Text(value, style: TextStyle(color: Colors.red)));
            }).toList(),
            hint: (_dropDownText == null)
                ? Text('Votre role')
                : Text(_dropDownText!),
            onChanged: (value) {
              value == 'Programmateur'
                  ? setState(() {
                _dropDownText = value;
              })
                  : setState(() {
                _dropDownText = 'Exploitant';
              });
            }),
      );

  }

}
class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? lastname;
  String? firstname;
  String? pw;
  TextEditingController? testPw = TextEditingController();
  String? pwConf;
  String failResponse = "La connexion a échoué. Veuillez reéssayer";
  bool showResponse = false;
  bool showLoading = false;


  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                // name
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
                onSaved: (lastname) => this.lastname = lastname,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Veuillez entrer votre nom',
                ),
              ),
              TextFormField(
                // name
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre prenom';
                  }
                  return null;
                },
                onSaved: (firstname) => this.firstname = firstname,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Veuillez entrer votre prénom',
                ),
              ),
              TextFormField(
                // email
                validator: MultiValidator([
                  RequiredValidator(
                      errorText: "Veuillez entrer votre adresse mail"),
                  EmailValidator(
                      errorText: "Veuillez choisir une adresse mail valide"),
                ]),
                onSaved: (email) => this.email = email,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: 'Email'),
              ),

              TextFormField(
                // pw
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: testPw,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
                  }
                  testPw!.text = value;
                  return null;
                },
                onSaved: (pw) => this.pw = pw,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Veuillez à nouveau entrer votre mot de passe',
                ),
              ),
              TextFormField(
                // pwconf
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                validator: (value) {
                  if (value == null || testPw!.text.toString() != value) {
                    return 'Les mots de passes ne correspondent pas';
                  }
                  return null;
                },
                onSaved: (pw) => pwConf = pw,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Veuillez confirmer votre mot de passe',
                ),
              ),
              const SizedBox(height: 12),
              SignUpFormSelect(),
              Visibility(visible: showResponse, child: Text(failResponse)),
              Visibility(
                  visible: showLoading,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                  )),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: submit,
                child: const Text('S\'inscrire'),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(title: 'Bienvenu',)),
                  // onPressed: submit,
                ),
                child: Text('J\'ai déja un compte'),
              ),
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
