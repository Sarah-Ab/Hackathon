import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import './main.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './authentification.dart';
import 'mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Test());
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        value: Auth().user,
        initialData: null,
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: const Wrapper(),
        ));
  }
}


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user != null) {
      return const Test2();
    } else {
      return const Test2();
    }
  }
}

class Test2 extends StatelessWidget {
  const Test2({Key? key}) : super(key: key);

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

  final TextEditingController emailController =
  TextEditingController(text: "");
  final TextEditingController passwordController =
  TextEditingController(text: "");
  final TextEditingController prenomController =
  TextEditingController(text: "");
  final TextEditingController nomController =
  TextEditingController(text: "");

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
                controller: nomController,
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
                controller: prenomController,
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
                controller: emailController,
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
                controller: passwordController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                //controller: testPw,
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
              const SignUpFormSelect(),
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

  /*Future submit() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        showLoading = true;
        showResponse = false;
      });
    }
  }*/
  Future submit() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() async {

        showResponse = false;
        try {
          await Auth().register(
              emailController.text,
              passwordController.text,
              prenomController.text,
              nomController.text);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const MainPageForm(title: 'Accueil',)));
          setState(() {
            showLoading = false;
          });
        } on Exception catch (e) {
          setState(() {
            print(e.toString());
            showLoading = false;
          });
        }});
    }
  }
}
