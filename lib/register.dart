import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';


void main() async {
  runApp( Test());
}
class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  MaterialApp(
        home: Scaffold(body: Center(
              child: SignUpForm(),
    ))
    );
  }
}

class SignUpForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => SignUpFormState();


}


class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? name;
  String? pw;
  TextEditingController? testPw = TextEditingController();
  String? pwConf;
  String failResponse = "Sign up failed. Please try again";
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

              TextFormField( // email
                validator: MultiValidator([
                  RequiredValidator(
                      errorText: "Veuillez entrer un adresse mail"),
                  EmailValidator(
                      errorText: "Veuillez entrer une adresse mail valide"),
                ]),
                onSaved: (email) => this.email = email,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: 'Email'),
              ),
              TextFormField( // name
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please write something';
                  }
                  return null;
                },
                onSaved: (name) => this.name = name,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Name',
                ),
              ),

              TextFormField( // pw
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: testPw,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please write something';
                  }
                  testPw!.text=value;
                  return null;
                },
                onSaved: (pw) => this.pw = pw,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Password',
                ),
              ),

              TextFormField( // pwconf
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                validator: (value) {
                  if (value == null || testPw!.text.toString() != value) {
                    return 'wrong password';
                  }
                  return null;
                },
                onSaved: (pw) => pwConf = pw,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Password c',
                ),
              ),
              const SizedBox(height: 12),
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
                child: const Text('Sign Up'),
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
